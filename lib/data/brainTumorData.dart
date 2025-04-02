import './model/brain_tumor.dart';

class BrainTumorData {
  static List<BrainTumor> getBrainTumorData() {
    return [
      BrainTumor(
        type: "glioma",
        description:
            "Gliomas are a type of tumor that occurs in the brain and spinal cord, originating from glial cells.",
        commonLocations: ["Cerebrum", "Brainstem", "Spinal cord"],
        symptoms: ["Headache", "Seizures", "Nausea", "Vision problems"],
        treatmentOptions: ["Surgery", "Radiotherapy", "Chemotherapy"],
      ),
      BrainTumor(
        type: "meningioma",
        description:
            "Meningiomas are typically slow-growing tumors that form in the meninges, the layers of tissue covering the brain and spinal cord.",
        commonLocations: ["Cerebral hemispheres", "Cerebellum", "Spinal cord"],
        symptoms: ["Headaches", "Vision loss", "Hearing problems", "Seizures"],
        treatmentOptions: ["Surgery", "Radiotherapy"],
      ),
      BrainTumor(
        type: "pituitary",
        description:
            "Pituitary tumors occur in the pituitary gland and can affect hormone production, leading to various hormonal imbalances.",
        commonLocations: ["Pituitary gland"],
        symptoms: [
          "Headaches",
          "Vision problems",
          "Fatigue",
          "Unexplained weight changes"
        ],
        treatmentOptions: ["Surgery", "Radiotherapy", "Medication"],
      ),
      BrainTumor(
        type: "noTumor",
        description:
            "No tumor detected. The patient does not have any brain tumor.",
        commonLocations: [],
        symptoms: ["None"],
        treatmentOptions: ["None"],
      ),
    ];
  }
}
