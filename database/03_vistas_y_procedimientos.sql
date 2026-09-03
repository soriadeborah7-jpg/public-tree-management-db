USE TP_BBDD1_2025_G06;
GO

CREATE VIEW vw_ReclamosConTiempos AS
WITH Fechas AS (
    SELECT r.ID_Reclamo,
        r.Fecha_reclamo,
        r.ID_Arbol,
        atr.Fecha_asignacion,
        t.Fecha_efectiva AS Fecha_resolucion
    FROM Reclamo r
    LEFT JOIN Asignacion_tarea_reclamo atr
        ON atr.ID_Reclamo = r.ID_Reclamo
    LEFT JOIN Tarea t
        ON t.ID_Tarea = atr.ID_Tarea
)
SELECT ID_Reclamo,
    Fecha_reclamo,
    ID_Arbol,
    DATEDIFF(
        DAY,
        Fecha_reclamo,
        ISNULL(Fecha_asignacion, CAST(GETDATE() AS date))
    ) AS Dias_hasta_asignacion,
    DATEDIFF(
        DAY,
        Fecha_reclamo,
        ISNULL(Fecha_resolucion, CAST(GETDATE() AS date))
    ) AS Dias_hasta_resolucion
FROM Fechas;
GO

CREATE VIEW vw_ResumenTareasRealizadas AS
SELECT tdt.ID_Tipo_de_tarea AS Numero_tipo_de_tarea,
    tdt.Descripcion AS Tipo_de_tarea,
    MIN(t.Fecha_efectiva) AS Primera_tarea,
    MAX(t.Fecha_efectiva) AS Ultima_tarea,
    COUNT(*)              AS Cantidad_tareas_realizadas
FROM Tarea t
JOIN Tipo_de_tarea tdt
    ON t.ID_Tipo_de_tarea = tdt.ID_Tipo_de_tarea
WHERE t.Fecha_efectiva IS NOT NULL
GROUP BY
    tdt.ID_Tipo_de_tarea,
    tdt.Descripcion;
GO

CREATE PROCEDURE usp_TareasPendientes
    @ID_Arbol        VARCHAR(50),
    @NombreTipoTarea VARCHAR(100),
    @ProximaFecha    DATE OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @CantidadPendientes INT;

    SELECT TOP 1 
        @ProximaFecha = t.Fecha_planificada
    FROM Tarea t
    JOIN Tipo_de_tarea tt
        ON t.ID_Tipo_de_tarea = tt.ID_Tipo_de_tarea
    JOIN Arboles_por_tarea apt
        ON apt.ID_Tarea = t.ID_Tarea
    WHERE apt.ID_Arbol = @ID_Arbol
      AND tt.Descripcion = @NombreTipoTarea
      AND t.Fecha_efectiva IS NULL
    ORDER BY t.Fecha_planificada ASC;

    SELECT 
        @CantidadPendientes = COUNT(*)
    FROM Tarea t
    JOIN Tipo_de_tarea tt
        ON t.ID_Tipo_de_tarea = tt.ID_Tipo_de_tarea
    JOIN Arboles_por_tarea at
        ON at.ID_Tarea = t.ID_Tarea
    WHERE at.ID_Arbol = @ID_Arbol
      AND tt.Descripcion = @NombreTipoTarea
      AND t.Fecha_efectiva IS NULL; 

    RETURN @CantidadPendientes;
END;
GO