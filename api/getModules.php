<?php
require_once("../connections/connect.php");

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $database = new Database();

    $query = "SELECT * FROM Modulo WHERE imagen IS NOT NULL";
    $result = $database->consult($query, []);
    if (!$result['resp']) {
        echo json_encode(['resp' => false, 'message' => '¡Ups! Hubo un error al consultar los modulos']);
        exit;
    }

    echo json_encode([
        'resp' => true,
        'data' => array_map(function ($data) {
            $binary_data = file_get_contents($data['imagen']);
            $base64_image = 'data:image/png;base64,' . base64_encode($binary_data);
            return [
                'id' => $data['id'],
                'nombre' => $data['nombre'],
                'imagen' => $base64_image,
                'descripcion' => $data['descripcion']
            ];
        }, $result['data'])
    ]);
}
