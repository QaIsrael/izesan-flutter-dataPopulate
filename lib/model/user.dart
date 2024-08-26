// import 'package:json_annotation/json_annotation.dart';
//
// part 'user.g.dart';
//
// @JsonSerializable()
// class User {
//   @JsonKey(name: 'name')
//   final String? name;
//
//   @JsonKey(name: 'phone')
//   final String? phone;
//
//   @JsonKey(name: 'email')
//   final String? email;
//
//   @JsonKey(name: 'refCode')
//   final String? refCode;
//
//   @JsonKey(name: 'disco_id')
//   final int? discoId;
//
//   @JsonKey(name: 'wallet')
//   final double? wallet;
//
//   @JsonKey(name: 'role')
//   final int? role;
//
//   @JsonKey(name: 'id')
//   final int? id;
//
//   @JsonKey(name: 'status')
//   final int? status;
//
//   @JsonKey(name: 'priority')
//   final bool? priority;
//
//   @JsonKey(name: 'secure')
//   final bool? secure;
//
//   @JsonKey(name: 'compliance_level')
//   final String? complianceLevel;
//
//   @JsonKey(name: 'supervisor')
//   final bool? supervisor;
//
//   @JsonKey(name: 'agent_status')
//   final int? agentStatus;
//
//   @JsonKey(name: 'agent_wallet')
//   final double? agentWallet;
//
//   User({
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.refCode,
//     required this.discoId,
//     required this.wallet,
//     required this.role,
//     required this.id,
//     required this.status,
//     required this.priority,
//     required this.secure,
//     required this.complianceLevel,
//     required this.supervisor,
//     required this.agentStatus,
//     required this.agentWallet,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }
