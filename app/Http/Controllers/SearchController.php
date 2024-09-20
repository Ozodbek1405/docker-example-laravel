<?php

namespace App\Http\Controllers;

use App\Services\ElasticsearchService;

class SearchController extends Controller
{
    protected ElasticsearchService $elasticsearchService;

    public function __construct(ElasticsearchService $elasticsearchService)
    {
        $this->elasticsearchService = $elasticsearchService;
    }

    public function search()
    {
        $params = [
            'index' => 'your_index',
            'body'  => [
                'query' => [
                    'match' => [
                        'field_name' => 'search_value',
                    ],
                ],
            ],
        ];

        $results = $this->elasticsearchService->search($params);
        return response()->json($results);
    }
}
