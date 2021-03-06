/****************************************************************************
 * Copyright 2016, Optimizely, Inc. and contributors                        *
 *                                                                          *
 * Licensed under the Apache License, Version 2.0 (the "License");          *
 * you may not use this file except in compliance with the License.         *
 * You may obtain a copy of the License at                                  *
 *                                                                          *
 *    http://www.apache.org/licenses/LICENSE-2.0                            *
 *                                                                          *
 * Unless required by applicable law or agreed to in writing, software      *
 * distributed under the License is distributed on an "AS IS" BASIS,        *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *
 * See the License for the specific language governing permissions and      *
 * limitations under the License.                                           *
 ***************************************************************************/

#import "OPTLYClient.h"
#ifdef UNIVERSAL
    #import "OPTLYVariation.h"
    #import "OPTLYLogger.h"
    #import "OPTLYLoggerMessages.h"
#else
    #import <OptimizelySDKCore/OPTLYVariation.h>
    #import <OptimizelySDKCore/OPTLYLogger.h>
    #import <OptimizelySDKCore/OPTLYLoggerMessages.h>
#endif


/**
 * This class wraps the Optimizely class from the Core SDK.
 * Optimizely Client Instance
 */
@implementation OPTLYClient

+ (nonnull instancetype)init:(OPTLYClientBuilderBlock)builderBlock {
    return [[self alloc] initWithBuilder:[OPTLYClientBuilder builderWithBlock:builderBlock]];
}

- (instancetype)init {
    return [self initWithBuilder:nil];
}

- (instancetype)initWithBuilder:(OPTLYClientBuilder *)builder {
    self = [super init];
    if (self) {
        if (builder != nil) {
            _optimizely = builder.optimizely;
            if (builder.logger != nil) {
                _logger = builder.logger;
            }
        }
    }
    return self;
}

#pragma mark activate methods
- (OPTLYVariation *)activate:(nonnull NSString *)experimentKey
                      userId:(nonnull NSString *)userId {
    return [self activate:experimentKey userId:userId attributes:nil];
}

- (OPTLYVariation *)activate:(NSString *)experimentKey
                      userId:(NSString *)userId
                  attributes:(NSDictionary<NSString *,NSString *> *)attributes {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return nil;
    }
    else {
        return [self.optimizely activate:experimentKey
                                  userId:userId
                              attributes:attributes];
    }
}

#pragma mark getVariation methods
- (OPTLYVariation *)variation:(NSString *)experimentKey
                       userId:(NSString *)userId {
    return [self variation:experimentKey
                    userId:userId
                attributes:nil];
}

- (OPTLYVariation *)variation:(NSString *)experimentKey
                       userId:(NSString *)userId
                   attributes:(NSDictionary<NSString *,NSString *> *)attributes {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return nil;
    }
    else {
        return [self.optimizely variation:experimentKey
                                   userId:userId
                               attributes:attributes];
    }
}

#pragma mark Forced Variation Methods

- (OPTLYVariation *)getForcedVariation:(nonnull NSString *)experimentKey
                                userId:(nonnull NSString *)userId {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return nil;
    }
    else {
        return [self.optimizely getForcedVariation:experimentKey
                                            userId:userId];
    }
}

- (BOOL)setForcedVariation:(nonnull NSString *)experimentKey
                    userId:(nonnull NSString *)userId
              variationKey:(nullable NSString *)variationKey {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return NO;
    }
    else {
        return [self.optimizely setForcedVariation:experimentKey
                                            userId:userId
                                      variationKey:variationKey];
    }
}

#pragma mark trackEvent methods
- (void)track:(NSString *)eventKey userId:(NSString *)userId
{
    [self track:eventKey userId:userId attributes:nil eventTags:nil eventValue:nil];
}

- (void)track:(NSString *)eventKey
       userId:(NSString *)userId
   attributes:(NSDictionary<NSString *, NSString *> * )attributes
{
    [self track:eventKey userId:userId attributes:attributes eventTags:nil eventValue:nil];
}

- (void)track:(NSString *)eventKey
       userId:(NSString *)userId
   eventValue:(NSNumber *)eventValue
{
    [self track:eventKey userId:userId attributes:nil eventTags:nil eventValue:eventValue];
}

- (void)track:(NSString *)eventKey
       userId:(NSString *)userId
    eventTags:(NSDictionary *)eventTags
{
    [self track:eventKey userId:userId attributes:nil eventTags:eventTags eventValue:nil];
}

- (void)track:(NSString *)eventKey
       userId:(NSString *)userId
   attributes:(NSDictionary *)attributes
   eventValue:(NSNumber *)eventValue
{
    [self track:eventKey userId:userId attributes:attributes eventTags:nil eventValue:eventValue];
}

- (void)track:(NSString *)eventKey
       userId:(NSString *)userId
   attributes:(NSDictionary *)attributes
    eventTags:(NSDictionary *)eventTags
{
    [self track:eventKey userId:userId attributes:attributes eventTags:eventTags eventValue:nil];
}

- (void)track:(NSString *)eventKey
       userId:(NSString *)userId
   attributes:(NSDictionary *)attributes
    eventTags:(NSDictionary *)eventTags
   eventValue:(NSNumber *)eventValue {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return;
    }
    [self.optimizely track:eventKey
                    userId:userId
                attributes:attributes
                 eventTags:eventTags
                eventValue:eventValue];
}

#pragma mark - Live variable getters

- (nullable NSString *)variableString:(nonnull NSString *)variableKey
                               userId:(nonnull NSString *)userId {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return nil;
    }
    return [self.optimizely variableString:variableKey
                                    userId:userId];
}

- (nullable NSString *)variableString:(nonnull NSString *)variableKey
                               userId:(nonnull NSString *)userId
                   activateExperiment:(BOOL)activateExperiment {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return nil;
    }
    return [self.optimizely variableString:variableKey
                                    userId:userId
                        activateExperiment:activateExperiment];
}

- (nullable NSString *)variableString:(nonnull NSString *)variableKey
                               userId:(nonnull NSString *)userId
                           attributes:(nullable NSDictionary *)attributes
                   activateExperiment:(BOOL)activateExperiment {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return nil;
    }
    return [self.optimizely variableString:variableKey
                                    userId:userId
                                attributes:attributes
                        activateExperiment:activateExperiment];
}

- (nullable NSString *)variableString:(nonnull NSString *)variableKey
                               userId:(nonnull NSString *)userId
                           attributes:(nullable NSDictionary *)attributes
                   activateExperiment:(BOOL)activateExperiment
                                error:(out NSError * _Nullable * _Nullable)error {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return nil;
    }
    return [self.optimizely variableString:variableKey
                                    userId:userId
                                attributes:attributes
                        activateExperiment:activateExperiment
                                     error:error];
}

- (BOOL)variableBoolean:(nonnull NSString *)variableKey
                 userId:(nonnull NSString *)userId {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return false;
    }
    return [self.optimizely variableBoolean:variableKey
                                     userId:userId];
}

- (BOOL)variableBoolean:(nonnull NSString *)variableKey
                 userId:(nonnull NSString *)userId
     activateExperiment:(BOOL)activateExperiment {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return false;
    }
    return [self.optimizely variableBoolean:variableKey
                                     userId:userId
                         activateExperiment:activateExperiment];
}

- (BOOL)variableBoolean:(nonnull NSString *)variableKey
                 userId:(nonnull NSString *)userId
             attributes:(nullable NSDictionary *)attributes
     activateExperiment:(BOOL)activateExperiment {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return false;
    }
    return [self.optimizely variableBoolean:variableKey
                                     userId:userId
                                 attributes:attributes
                         activateExperiment:activateExperiment];
}

- (BOOL)variableBoolean:(nonnull NSString *)variableKey
                 userId:(nonnull NSString *)userId
             attributes:(nullable NSDictionary *)attributes
     activateExperiment:(BOOL)activateExperiment
                  error:(out NSError * _Nullable * _Nullable)error {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return false;
    }
    return [self.optimizely variableBoolean:variableKey
                                     userId:userId
                                 attributes:attributes
                         activateExperiment:activateExperiment
                                      error:error];
}

- (NSInteger)variableInteger:(nonnull NSString *)variableKey
                      userId:(nonnull NSString *)userId {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return 0;
    }
    return [self.optimizely variableInteger:variableKey
                                     userId:userId];
}

- (NSInteger)variableInteger:(nonnull NSString *)variableKey
                      userId:(nonnull NSString *)userId
          activateExperiment:(BOOL)activateExperiment {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return 0;
    }
    return [self.optimizely variableInteger:variableKey
                                     userId:userId
                         activateExperiment:activateExperiment];
}

- (NSInteger)variableInteger:(nonnull NSString *)variableKey
                      userId:(nonnull NSString *)userId
                  attributes:(nullable NSDictionary *)attributes
          activateExperiment:(BOOL)activateExperiment {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return 0;
    }
    return [self.optimizely variableInteger:variableKey
                                     userId:userId
                                 attributes:attributes
                         activateExperiment:activateExperiment];
}

- (NSInteger)variableInteger:(nonnull NSString *)variableKey
                      userId:(nonnull NSString *)userId
                  attributes:(nullable NSDictionary *)attributes
          activateExperiment:(BOOL)activateExperiment
                       error:(out NSError * _Nullable * _Nullable)error {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return 0;
    }
    return [self.optimizely variableInteger:variableKey
                                     userId:userId
                                 attributes:attributes
                         activateExperiment:activateExperiment
                                      error:error];
}

- (double)variableDouble:(nonnull NSString *)variableKey
                  userId:(nonnull NSString *)userId {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return 0;
    }
    return [self.optimizely variableDouble:variableKey
                                    userId:userId];
}

- (double)variableDouble:(nonnull NSString *)variableKey
                  userId:(nonnull NSString *)userId
      activateExperiment:(BOOL)activateExperiment {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return 0;
    }
    return [self.optimizely variableDouble:variableKey
                                    userId:userId
                        activateExperiment:activateExperiment];
}

- (double)variableDouble:(nonnull NSString *)variableKey
                  userId:(nonnull NSString *)userId
              attributes:(nullable NSDictionary *)attributes
      activateExperiment:(BOOL)activateExperiment {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return 0;
    }
    return [self.optimizely variableDouble:variableKey
                                    userId:userId
                                attributes:attributes
                        activateExperiment:activateExperiment];
}

- (double)variableDouble:(nonnull NSString *)variableKey
                  userId:(nonnull NSString *)userId
              attributes:(nullable NSDictionary *)attributes
      activateExperiment:(BOOL)activateExperiment
                   error:(out NSError * _Nullable * _Nullable)error {
    if (self.optimizely == nil) {
        [self.logger logMessage:OPTLYLoggerMessagesClientDummyOptimizelyError
                      withLevel:OptimizelyLogLevelError];
        return 0;
    }
    return [self.optimizely variableDouble:variableKey
                                    userId:userId
                                attributes:attributes
                        activateExperiment:activateExperiment
                                     error:error];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Optimizely: %@ \nlogger:%@\n", self.optimizely, self.logger];
}

@end
