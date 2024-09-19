<?php
require_once("../connections/connect.php");

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $database = new Database();

    if (!key_exists('id', $_GET)) {
        echo json_encode(['resp' => false, 'message' => 'El dato id es obligatorio']);
        exit;
    }

    $id = $_GET['id'];
    if (empty($id)) {
        echo json_encode(['resp' => false, 'message' => 'El dato id no puede ser vacio']);
        exit;
    }

    $query = "SELECT * FROM SubModulo WHERE moduloId = ?";
    $result = $database->consult($query, [$id]);


    if (!$result['resp']) {
        echo json_encode(['resp' => false, 'message' => '!Ups! Hubo un error al consultar la informacion']);
        exit;
    }


    echo json_encode([
        'resp' => true,
        'data' => array_map(function ($data) {
            if (empty($data['imagenTitulo'])) {
                $base64_image = null;
            } else {
                $binary_data = file_get_contents($data['imagenTitulo']);
                $base64_image = 'data:image/png;base64,' . base64_encode($binary_data);
            }

            return [
                'id' =>  $data['id'],
                'moduloId' => $data['moduloId'],
                'titulo' => $data['titulo'],
                'contenido' => $data['contenido'],
                'imagenTitulo' => $base64_image,
                'isImage' => $data['isImage'],
                'isVideo' => $data['isVideo']
            ];
        }, $result['data'])
    ]);
}
