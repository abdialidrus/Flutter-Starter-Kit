{{#include_example_feature}}
import 'package:{{project_name.snakeCase()}}/domain/entities/news_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

/// News Model - Data layer dengan JSON serialization
@JsonSerializable(explicitToJson: true)
class NewsModel {
  @JsonKey(name: 'article_id')
  final String? articleId;

  final String? title;
  final String? link;
  final List<String>? keywords;
  final List<String>? creator;

  @JsonKey(name: 'video_url')
  final String? videoUrl;

  final String? description;
  final String? content;

  @JsonKey(name: 'pubDate')
  final String? pubDate;

  @JsonKey(name: 'pubDateTZ')
  final String? pubDateTZ;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'source_id')
  final String? sourceId;

  @JsonKey(name: 'source_priority')
  final int? sourcePriority;

  @JsonKey(name: 'source_name')
  final String? sourceName;

  @JsonKey(name: 'source_url')
  final String? sourceUrl;

  @JsonKey(name: 'source_icon')
  final String? sourceIcon;

  final String? language;
  final List<String>? country;
  final List<String>? category;

  @JsonKey(name: 'ai_tag')
  final String? aiTag;

  final String? sentiment;

  @JsonKey(name: 'sentiment_stats')
  final String? sentimentStats;

  @JsonKey(name: 'ai_region')
  final String? aiRegion;

  @JsonKey(name: 'ai_org')
  final String? aiOrg;

  final bool? duplicate;

  const NewsModel({
    this.articleId,
    this.title,
    this.link,
    this.keywords,
    this.creator,
    this.videoUrl,
    this.description,
    this.content,
    this.pubDate,
    this.pubDateTZ,
    this.imageUrl,
    this.sourceId,
    this.sourcePriority,
    this.sourceName,
    this.sourceUrl,
    this.sourceIcon,
    this.language,
    this.country,
    this.category,
    this.aiTag,
    this.sentiment,
    this.sentimentStats,
    this.aiRegion,
    this.aiOrg,
    this.duplicate,
  });

  /// From JSON
  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  /// Convert to Entity
  NewsEntity toEntity() {
    return NewsEntity(
      articleId: articleId,
      title: title,
      link: link,
      keywords: keywords,
      creator: creator,
      videoUrl: videoUrl,
      description: description,
      content: content,
      pubDate: pubDate,
      pubDateTZ: pubDateTZ,
      imageUrl: imageUrl,
      sourceId: sourceId,
      sourcePriority: sourcePriority,
      sourceName: sourceName,
      sourceUrl: sourceUrl,
      sourceIcon: sourceIcon,
      language: language,
      country: country,
      category: category,
      aiTag: aiTag,
      sentiment: sentiment,
      sentimentStats: sentimentStats,
      aiRegion: aiRegion,
      aiOrg: aiOrg,
      duplicate: duplicate,
    );
  }

  /// From Entity
  factory NewsModel.fromEntity(NewsEntity entity) {
    return NewsModel(
      articleId: entity.articleId,
      title: entity.title,
      link: entity.link,
      keywords: entity.keywords,
      creator: entity.creator,
      videoUrl: entity.videoUrl,
      description: entity.description,
      content: entity.content,
      pubDate: entity.pubDate,
      pubDateTZ: entity.pubDateTZ,
      imageUrl: entity.imageUrl,
      sourceId: entity.sourceId,
      sourcePriority: entity.sourcePriority,
      sourceName: entity.sourceName,
      sourceUrl: entity.sourceUrl,
      sourceIcon: entity.sourceIcon,
      language: entity.language,
      country: entity.country,
      category: entity.category,
      aiTag: entity.aiTag,
      sentiment: entity.sentiment,
      sentimentStats: entity.sentimentStats,
      aiRegion: entity.aiRegion,
      aiOrg: entity.aiOrg,
      duplicate: entity.duplicate,
    );
  }
}

/// News Response Model
@JsonSerializable()
class NewsResponseModel {
  final String? status;
  final int? totalResults;
  final List<NewsModel>? results;
  final String? nextPage;

  const NewsResponseModel({
    this.status,
    this.totalResults,
    this.results,
    this.nextPage,
  });

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseModelToJson(this);
}
{{/include_example_feature}}
