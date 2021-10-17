<?php

namespace App\Controller;

use Doctrine\DBAL\Connection;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends AbstractController
{
    #[Route('/', name: 'default')]
    public function index(Connection $connection): Response
    {
        $connection->connect();
        return $this->render('default/index.html.twig', [
            'version' => PHP_VERSION,
            'container' => $_ENV['HOSTNAME'] ?? '',
            'db' => $connection->isConnected()
        ]);
    }
}
