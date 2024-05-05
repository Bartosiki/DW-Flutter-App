import 'package:dw_flutter_app/clients/vertex_http_client.dart';
import 'package:dw_flutter_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  void main() async {
    const apiKey =
        "ya29.c.c0AY_VpZjiVz7BpZvw5bPAIl3AT09sdJsmwShAPNtisaBQ0on6ZHEZ6BousWQjJcu2_of55KTOHCUbxgXRx69LHLwt9FxNvUSzT7Ur9AGaWKB1d-A--QKELuV0yQ9WyZ7iTWMRSdp-kKOa75vjkqWWZk8_VqmoyrzeF5MK0PxYH1K1WZWEtVg3ruMDJAuuc9slr8S_O5NdyBZ83spiObwJVKIp0FyAo-yxrQJZc9g8eWpN9R6deVxDLu5X6n9B4hcnRNlAYvRQAo7DYiQWI_aMMlrmJ3UYLpjg9pgebOoyYx3a-TxTJbNq5-0q7a0f8ON7EIy8Zb60PetSYNoGSygvmInm8zbSQXne-C__fQ0ERmY_seqawswuf_8N384KS5BS-O2rbXZW-08Zp4SetMpq3rwamMeOx2cjWum1ozFO2cnS1W17Fk__j6M7xOnf_piewgMt75UitOb23FlW20MckyhYBne9qcuxrhZF5yBkwzohl_BRlXI4x7q0i2Ue3WteiUFgM2U0xzZwZ4O3hxwnYJwajkx4ytl1dg1igYUwcui23VqcJkfcYk2BnnuWJUWIIndn-szRIXm7YWBbyv98RO1_vii_6Rdq-9UlJ6qUM9o94W70eou5hW2SspcSu4276ckQYW3SkgxfMQe6mJ84pnu7RzJodFVbuj005evS8ezqUa-jv803rpZivg6fl1e49r1tI0qFXBx0SeauUFIuVZBfaw6n3j9c45Jiglabb8Ize_z6cF0pe7gIe7pQniqslMyRtehgXmul7QX_zXilfkh3-FjX7-6W8k6fsv-xMXUngvkg5_qy-VpcfWU3BwbMJkzoSFrXR8fU4BizR25pybhqxhhS3nWoVlqwlsMVmaI3FfUX9r5iaiwm_WmZo-9kJbZj0IxU_nwF8S24bzzdjYmrVrQkeOktmB-X75d0dx_wB1thtpMh8jSSZpWy3sl_UcWgpjO1fUXpaXlbq4dujxm4QIS240777_6w41033tg0Fcmn6ii9a7V";
    const projectUrl =
        'https://us-central1-aiplatform.googleapis.com/v1/projects/dw-flutter-app/locations/us-central1/publishers/google/models';
    final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: apiKey,
        httpClient: VertexHttpClient(projectUrl));

    final prompt = 'Write a story about a magic backpack.';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    print(response.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.assistant),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(Strings.assistant),
          ],
        ),
      ),
    );
  }
}
