import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  const baseUrl = 'http://test.local';

  test('getProjects mem-parsing daftar proyek dari JSON snake_case', () async {
    final client = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.toString(), '$baseUrl/api/v1/projects/');
        return http.Response(
          jsonEncode([
            {
              'id': 'abc',
              'title': 'Portfolio',
              'description': 'Website',
              'category': 'Web Development',
              'project_image_url': null,
              'star_count': 3,
            },
          ]),
          200,
        );
      }),
    );

    final projects = await client.getProjects();

    expect(projects, hasLength(1));
    expect(projects.first.id, 'abc');
    expect(projects.first.projectImageUrl, '');
    expect(projects.first.starCount, 3);
  });

  test('createProject mengirim header token dan tidak mengirim id', () async {
    final client = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.headers['Authorization'], 'Token secret');
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body.containsKey('id'), isFalse);
        expect(body['project_image_url'], '');
        return http.Response(jsonEncode({...body, 'id': 'new-id'}), 201);
      }),
    );

    final created = await client.createProject(
      const Project(title: 'App', description: 'Mobile', category: 'Other'),
      token: 'secret',
    );

    expect(created.id, 'new-id');
  });

  test('obtainToken mengembalikan token dan error dilempar sebagai '
      'ApiException', () async {
    final client = ApiClient(
      baseUrl: baseUrl,
      client: MockClient((request) async {
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        if (body['password'] == 'benar') {
          return http.Response(jsonEncode({'token': 'tok123'}), 200);
        }
        return http.Response('{"non_field_errors": ["invalid"]}', 400);
      }),
    );

    expect(await client.obtainToken('owner', 'benar'), 'tok123');
    expect(
      () => client.obtainToken('owner', 'salah'),
      throwsA(
        isA<ApiException>().having((e) => e.statusCode, 'statusCode', 400),
      ),
    );
  });
}
