/****************************************************************************
 * Copyright 2016-2017, Optimizely, Inc. and contributors                   *
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
#ifdef UNIVERSAL
    #import "OPTLYErrorHandler.h"
    #import "OPTLYEventDispatcher.h"
    #import "OPTLYLogger.h"
#else
    #import <OptimizelySDKCore/OPTLYErrorHandler.h>
    #import <OptimizelySDKCore/OPTLYEventDispatcherBasic.h>
    #import <OptimizelySDKCore/OPTLYLogger.h>
#endif

#import "OPTLYManagerBuilder.h"
#import "OPTLYDatafileManagerBasic.h"

@implementation OPTLYManagerBuilder

+ (nullable instancetype)builderWithBlock:(OPTLYManagerBuilderBlock)block {
    return [[self alloc] initWithBlock:block];
}

- (id)init {
    return [self initWithBlock:nil];
}

- (id)initWithBlock:(OPTLYManagerBuilderBlock)block {
    NSParameterAssert(block);
    self = [super init];
    if (self != nil) {
        block(self);
        
        // check the logger
        if (_logger) {
            if (![OPTLYLoggerUtility conformsToOPTLYLoggerProtocol:[_logger class]]) {
                [_logger logMessage:OPTLYLoggerMessagesManagerLoggerDoesNotConformToOPTLYLoggerProtocol
                          withLevel:OptimizelyLogLevelError];
                return nil;
            }
        }
        
        // check the error handler
        if (_errorHandler) {
            if (![OPTLYErrorHandler conformsToOPTLYErrorHandlerProtocol:[_errorHandler class]]) {
                [_logger logMessage:OPTLYLoggerMessagesManagerErrorHandlerDoesNotConformToOPTLYErrorHandlerProtocol
                          withLevel:OptimizelyLogLevelError];
                return nil;
            }
        }
        
        // check the datafile manager
        if (_datafileManager) {
            if (![OPTLYDatafileManagerUtility conformsToOPTLYDatafileManagerProtocol:[_datafileManager class]]) {
                [_logger logMessage:OPTLYLoggerMessagesManagerDatafileManagerDoesNotConformToOPTLYDatafileManagerProtocol
                          withLevel:OptimizelyLogLevelError];
                return nil;
            }
        }
        
        // check event dispatcher
        if (_eventDispatcher) {
            if (![OPTLYEventDispatcherUtility conformsToOPTLYEventDispatcherProtocol:[_eventDispatcher class]]) {
                [_logger logMessage:OPTLYLoggerMessagesManagerEventDispatcherDoesNotConformToOPTLYEventDispatcherProtocol
                          withLevel:OptimizelyLogLevelError];
                return nil;
            }
        }
        
        // check the project id
        if (_projectId == nil) {
            [_logger logMessage:OPTLYLoggerMessagesManagerMustBeInitializedWithProjectId
                      withLevel:OptimizelyLogLevelError];
            return nil;
        }
        
        if ([_projectId isEqualToString:@""]) {
            [_logger logMessage:OPTLYLoggerMessagesManagerProjectIdCannotBeEmptyString
                      withLevel:OptimizelyLogLevelError];
            return nil;
        }
        
    }
    return self;
}

@end
