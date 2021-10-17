<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends AbstractController
{
    #[Route('/', name: 'default')]
    public function index(): Response
    {
        $response = $this->render('default/index.html.twig', [
            'version' => PHP_VERSION,
            'container' => $_ENV['HOSTNAME'] ?? ''
        ]);

        $response->setSharedMaxAge(3600);
        $response->headers->addCacheControlDirective('must-revalidate', true);

        return $response;
    }
}
