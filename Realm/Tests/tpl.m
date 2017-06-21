////////////////////////////////////////////////////////////////////////////
//
// Copyright 2017 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import "RLMTestCase.h"

@interface PrimitiveArrayPropertyTests : RLMTestCase
@end

@implementation PrimitiveArrayPropertyTests {
    AllPrimitiveArrays *unmanaged;
    AllPrimitiveArrays *managed;
    AllOptionalPrimitiveArrays *optUnmanaged;
    AllOptionalPrimitiveArrays *optManaged;
    RLMRealm *realm;
}

- (void)setUp {
    unmanaged = [[AllPrimitiveArrays alloc] init];
    optUnmanaged = [[AllOptionalPrimitiveArrays alloc] init];
    realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    managed = [AllPrimitiveArrays createInRealm:realm withValue:@[]];
    optManaged = [AllOptionalPrimitiveArrays createInRealm:realm withValue:@[]];
}

- (void)tearDown {
    [realm cancelWriteTransaction];
}

#pragma mark - Unmanaged

- (void)testUnmanagedCount {
    XCTAssertEqual(unmanaged.intObj.count, 0U);
    [unmanaged.intObj addObject:@1];
    XCTAssertEqual(unmanaged.intObj.count, 1U);
}

- (void)testUnmanagedType {
    XCTAssertEqual(unmanaged.boolObj.type, RLMPropertyTypeBool);
    XCTAssertEqual(unmanaged.intObj.type, RLMPropertyTypeInt);
    XCTAssertEqual(unmanaged.floatObj.type, RLMPropertyTypeFloat);
    XCTAssertEqual(unmanaged.doubleObj.type, RLMPropertyTypeDouble);
    XCTAssertEqual(unmanaged.stringObj.type, RLMPropertyTypeString);
    XCTAssertEqual(unmanaged.dataObj.type, RLMPropertyTypeData);
    XCTAssertEqual(unmanaged.dateObj.type, RLMPropertyTypeDate);
    XCTAssertEqual(optUnmanaged.boolObj.type, RLMPropertyTypeBool);
    XCTAssertEqual(optUnmanaged.intObj.type, RLMPropertyTypeInt);
    XCTAssertEqual(optUnmanaged.floatObj.type, RLMPropertyTypeFloat);
    XCTAssertEqual(optUnmanaged.doubleObj.type, RLMPropertyTypeDouble);
    XCTAssertEqual(optUnmanaged.stringObj.type, RLMPropertyTypeString);
    XCTAssertEqual(optUnmanaged.dataObj.type, RLMPropertyTypeData);
    XCTAssertEqual(optUnmanaged.dateObj.type, RLMPropertyTypeDate);
}

- (void)testUnmanagedOptional {
    XCTAssertFalse(unmanaged.boolObj.optional);
    XCTAssertFalse(unmanaged.intObj.optional);
    XCTAssertFalse(unmanaged.floatObj.optional);
    XCTAssertFalse(unmanaged.doubleObj.optional);
    XCTAssertFalse(unmanaged.stringObj.optional);
    XCTAssertFalse(unmanaged.dataObj.optional);
    XCTAssertFalse(unmanaged.dateObj.optional);
    XCTAssertTrue(optUnmanaged.boolObj.optional);
    XCTAssertTrue(optUnmanaged.intObj.optional);
    XCTAssertTrue(optUnmanaged.floatObj.optional);
    XCTAssertTrue(optUnmanaged.doubleObj.optional);
    XCTAssertTrue(optUnmanaged.stringObj.optional);
    XCTAssertTrue(optUnmanaged.dataObj.optional);
    XCTAssertTrue(optUnmanaged.dateObj.optional);
}

- (void)testUnmanagedObjectClassName {
    XCTAssertNil(unmanaged.boolObj.objectClassName);
    XCTAssertNil(unmanaged.intObj.objectClassName);
    XCTAssertNil(unmanaged.floatObj.objectClassName);
    XCTAssertNil(unmanaged.doubleObj.objectClassName);
    XCTAssertNil(unmanaged.stringObj.objectClassName);
    XCTAssertNil(unmanaged.dataObj.objectClassName);
    XCTAssertNil(unmanaged.dateObj.objectClassName);
    XCTAssertNil(optUnmanaged.boolObj.objectClassName);
    XCTAssertNil(optUnmanaged.intObj.objectClassName);
    XCTAssertNil(optUnmanaged.floatObj.objectClassName);
    XCTAssertNil(optUnmanaged.doubleObj.objectClassName);
    XCTAssertNil(optUnmanaged.stringObj.objectClassName);
    XCTAssertNil(optUnmanaged.dataObj.objectClassName);
    XCTAssertNil(optUnmanaged.dateObj.objectClassName);
}

- (void)testUnmanagedRealm {
    XCTAssertNil(unmanaged.boolObj.realm);
    XCTAssertNil(unmanaged.intObj.realm);
    XCTAssertNil(unmanaged.floatObj.realm);
    XCTAssertNil(unmanaged.doubleObj.realm);
    XCTAssertNil(unmanaged.stringObj.realm);
    XCTAssertNil(unmanaged.dataObj.realm);
    XCTAssertNil(unmanaged.dateObj.realm);
    XCTAssertNil(optUnmanaged.boolObj.realm);
    XCTAssertNil(optUnmanaged.intObj.realm);
    XCTAssertNil(optUnmanaged.floatObj.realm);
    XCTAssertNil(optUnmanaged.doubleObj.realm);
    XCTAssertNil(optUnmanaged.stringObj.realm);
    XCTAssertNil(optUnmanaged.dataObj.realm);
    XCTAssertNil(optUnmanaged.dateObj.realm);
}

- (void)testUnmanagedInvalidated {
    RLMArray *array;
    @autoreleasepool {
        AllPrimitiveArrays *obj = [[AllPrimitiveArrays alloc] init];
        array = obj.intObj;
        XCTAssertFalse(array.invalidated);
    }
    XCTAssertFalse(array.invalidated);
}


// unmanaged.boolObj @YES @NO
// unmanaged.intObj @2 @3
// unmanaged.floatObj @2.2f @3.3f
// unmanaged.doubleObj @2.2 @3.3
// unmanaged.stringObj @"a" @"b"
// unmanaged.dataObj data(1) data(2)
// unmanaged.dateObj date(1) date(2)
// optUnmanaged.boolObj @YES @NO NSNull.null
// optUnmanaged.intObj @2 @3 NSNull.null
// optUnmanaged.floatObj @2.2f @3.3f NSNull.null
// optUnmanaged.doubleObj @2.2 @3.3 NSNull.null
// optUnmanaged.stringObj @"a" @"b" NSNull.null
// optUnmanaged.dataObj data(1) data(2) NSNull.null
// optUnmanaged.dateObj date(1) date(2) NSNull.null

static NSDate *date(int i) {
    return [NSDate dateWithTimeIntervalSince1970:i];
}
static NSData *data(int i) {
    return [NSData dataWithBytesNoCopy:calloc(i, 1) length:i freeWhenDone:YES];
}

- (void)testUnmanagedObjectAtIndex {
    RLMAssertThrowsWithReason([unmanaged.intObj objectAtIndex:0],
                              @"Index 0 is out of bounds (must be less than 0).");

    [unmanaged.intObj addObject:@1];
    XCTAssertEqualObjects([unmanaged.intObj objectAtIndex:0], @1);
}

- (void)testUnmanagedFirstObject {
    XCTAssertNil($array.firstObject);

    %r [$array addObjects:$values];
    %r XCTAssertEqualObjects($array.firstObject, $first);

    %o [$array addObject:NSNull.null];
    %o XCTAssertEqualObjects($array.firstObject, NSNull.null);

    %o [$array removeAllObjects];

    %o [$array addObjects:$values];
    %o XCTAssertEqualObjects($array.firstObject, $first);
}

- (void)testUnmanagedLastObject {
    XCTAssertNil($array.lastObject);

    [$array addObjects:$values];
    XCTAssertEqualObjects($array.lastObject, $last);

    %o [$array removeLastObject];
    %o XCTAssertEqualObjects($array.lastObject, $v1);
}

- (void)testUnmanagedAddObject {
    RLMAssertThrowsWithReason([$array addObject:$wrong], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");
    %r RLMAssertThrowsWithReason([$array addObject:NSNull.null], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");

    [$array addObject:$v0];
    XCTAssertEqualObjects($array[0], $v0);

    %o [$array addObject:NSNull.null];
    %o XCTAssertEqualObjects($array[1], NSNull.null);
}

- (void)testUnmanagedAddObjects {
    RLMAssertThrowsWithReason([$array addObjects:@[$wrong]], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");
    %r RLMAssertThrowsWithReason([$array addObjects:@[NSNull.null]], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");

    [$array addObjects:$values];
    XCTAssertEqualObjects($array[0], $v0);
    XCTAssertEqualObjects($array[1], $v1);
    %o XCTAssertEqualObjects($array[2], NSNull.null);
}

- (void)testUnmanagedInsertObject {
    RLMAssertThrowsWithReason([$array insertObject:$wrong atIndex:0], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");
    %r RLMAssertThrowsWithReason([$array insertObject:NSNull.null atIndex:0], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");
    RLMAssertThrowsWithReason([$array insertObject:$v0 atIndex:1], ^n @"Index 1 is out of bounds (must be less than 1).");

    [$array insertObject:$v0 atIndex:0];
    XCTAssertEqualObjects($array[0], $v0);

    [$array insertObject:$v1 atIndex:0];
    XCTAssertEqualObjects($array[0], $v1);
    XCTAssertEqualObjects($array[1], $v0);

    %o [$array insertObject:NSNull.null atIndex:1];
    %o XCTAssertEqualObjects($array[0], $v1);
    %o XCTAssertEqualObjects($array[1], NSNull.null);
    %o XCTAssertEqualObjects($array[2], $v0);
}

- (void)testUnmanagedRemoveObject {
    RLMAssertThrowsWithReason([$array removeObjectAtIndex:0], ^n @"Index 0 is out of bounds (must be less than 0).");

    [$array addObjects:$values];
    %r XCTAssertEqual($array.count, 2U);
    %o XCTAssertEqual($array.count, 3U);

    %r RLMAssertThrowsWithReason([$array removeObjectAtIndex:2], ^n @"Index 2 is out of bounds (must be less than 2).");
    %o RLMAssertThrowsWithReason([$array removeObjectAtIndex:3], ^n @"Index 3 is out of bounds (must be less than 3).");

    [$array removeObjectAtIndex:0];
    %r XCTAssertEqual($array.count, 1U);
    %o XCTAssertEqual($array.count, 2U);

    XCTAssertEqualObjects($array[0], $v1);
    %o XCTAssertEqualObjects($array[1], NSNull.null);
}

- (void)testUnmanagedRemoveLastObject {
    XCTAssertNoThrow([$array removeLastObject]);

    [$array addObjects:$values];
    %r XCTAssertEqual($array.count, 2U);
    %o XCTAssertEqual($array.count, 3U);

    [$array removeLastObject];
    %r XCTAssertEqual($array.count, 1U);
    %o XCTAssertEqual($array.count, 2U);

    XCTAssertEqualObjects($array[0], $v0);
    %o XCTAssertEqualObjects($array[1], $v1);
}

- (void)testUnmanagedReplace {
    RLMAssertThrowsWithReason([$array replaceObjectAtIndex:0 withObject:$v0], ^n @"Index 0 is out of bounds (must be less than 0).");

    [$array addObject:$v0]; ^nl [$array replaceObjectAtIndex:0 withObject:$v1]; ^nl XCTAssertEqualObjects($array[0], $v1); ^nl 

    %o [$array replaceObjectAtIndex:0 withObject:NSNull.null]; ^nl XCTAssertEqualObjects($array[0], NSNull.null);

    RLMAssertThrowsWithReason([$array replaceObjectAtIndex:0 withObject:$wrong], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");
    %r RLMAssertThrowsWithReason([$array replaceObjectAtIndex:0 withObject:NSNull.null], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");
}

- (void)testUnmanagedMove {
    RLMAssertThrowsWithReason([$array moveObjectAtIndex:0 toIndex:1], ^n @"Index 0 is out of bounds (must be less than 0).");
    RLMAssertThrowsWithReason([$array moveObjectAtIndex:1 toIndex:0], ^n @"Index 1 is out of bounds (must be less than 0).");

    [$array addObjects:@[$v0, $v1, $v0, $v1]];

    [$array moveObjectAtIndex:2 toIndex:0];

    XCTAssertEqualObjects([$array valueForKey:@"self"], ^n (@[$v0, $v0, $v1, $v1]));
}

- (void)testUnmanagedExchange {
    RLMAssertThrowsWithReason([$array exchangeObjectAtIndex:0 withObjectAtIndex:1], ^n @"Index 0 is out of bounds (must be less than 0).");
    RLMAssertThrowsWithReason([$array exchangeObjectAtIndex:1 withObjectAtIndex:0], ^n @"Index 1 is out of bounds (must be less than 0).");

    [$array addObjects:@[$v0, $v1, $v0, $v1]];

    [$array exchangeObjectAtIndex:2 withObjectAtIndex:1];

    XCTAssertEqualObjects([$array valueForKey:@"self"], ^n (@[$v0, $v0, $v1, $v1]));
}

- (void)testUnmanagedIndexOfObject {
    XCTAssertEqual(NSNotFound, [$array indexOfObject:$v0]);

    RLMAssertThrowsWithReason([$array indexOfObject:$wrong], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");

    %r RLMAssertThrowsWithReason([$array indexOfObject:NSNull.null], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");
    %o XCTAssertEqual(NSNotFound, [$array indexOfObject:NSNull.null]);

    [$array addObjects:$values];

    XCTAssertEqual(1U, [$array indexOfObject:$v1]);
}

- (void)testUnmanagedIndexOfObjectWhere {
    XCTAssertEqual(NSNotFound, [$array indexOfObjectWhere:@"TRUEPREDICATE"]);

    [$array addObjects:$values];

    XCTAssertEqual(0U, [$array indexOfObjectWhere:@"TRUEPREDICATE"]);
    XCTAssertEqual(NSNotFound, [$array indexOfObjectWhere:@"FALSEPREDICATE"]);
}

- (void)testUnmanagedIndexOfObjectWithPredicate {
    XCTAssertEqual(NSNotFound, [$array indexOfObjectWithPredicate:[NSPredicate predicateWithValue:YES]]);

    [$array addObjects:$values];

    XCTAssertEqual(0U, [$array indexOfObjectWithPredicate:[NSPredicate predicateWithValue:YES]]);
    XCTAssertEqual(NSNotFound, [$array indexOfObjectWithPredicate:[NSPredicate predicateWithValue:NO]]);
}

- (void)testUnmanagedSort {
    %unman RLMAssertThrowsWithReason([$array sortedResultsUsingKeyPath:@"self" ascending:NO], ^n @"This method may only be called on RLMArray instances retrieved from an RLMRealm");
}

- (void)testUnmanagedFilter {
    %unman RLMAssertThrowsWithReason([$array objectsWhere:@"TRUEPREDICATE"], ^n @"This method may only be called on RLMArray instances retrieved from an RLMRealm");
    %unman RLMAssertThrowsWithReason([$array objectsWithPredicate:[NSPredicate predicateWithValue:YES]], ^n @"This method may only be called on RLMArray instances retrieved from an RLMRealm");
}

- (void)testUnmanagedNotifications {
    %unman RLMAssertThrowsWithReason([$array addNotificationBlock:^(__unused id a, __unused id c, __unused id e) { }], ^n @"This method may only be called on RLMArray instances retrieved from an RLMRealm");
}

- (void)testUnmanagedMin {
    %nominmax RLMAssertThrowsWithReason([$array minOfProperty:@"self"], ^n @"minOfProperty: is not supported for $type array");

    %minmax XCTAssertNil([$array minOfProperty:@"self"]);

    %minmax [$array addObjects:$values];

    %minmax XCTAssertEqualObjects([$array minOfProperty:@"self"], $v0);
}

- (void)testUnmanagedMax {
    %nominmax RLMAssertThrowsWithReason([$array maxOfProperty:@"self"], ^n @"maxOfProperty: is not supported for $type array");

    %minmax XCTAssertNil([$array maxOfProperty:@"self"]);

    %minmax [$array addObjects:$values];

    %minmax XCTAssertEqualObjects([$array maxOfProperty:@"self"], $v1);
}

- (void)testUnmanagedSum {
    %nosum RLMAssertThrowsWithReason([$array sumOfProperty:@"self"], ^n @"sumOfProperty: is not supported for $type array");

    %sum XCTAssertEqualObjects([$array sumOfProperty:@"self"], @0);

    %sum [$array addObjects:$values];

    %sum XCTAssertEqualObjects([$array sumOfProperty:@"self"], @($s0 + $s1));
}

- (void)testUnmanagedAverage {
    %noavg RLMAssertThrowsWithReason([$array averageOfProperty:@"self"], ^n @"averageOfProperty: is not supported for $type array");

    %avg XCTAssertNil([$array averageOfProperty:@"self"]);

    %avg [$array addObjects:$values];

    %avg XCTAssertEqualWithAccuracy([$array averageOfProperty:@"self"].doubleValue, ($s0 + $s1) / 2.0, .001);
}

- (void)testUnmanagedFastEnumeration {
    for (int i = 0; i < 10; ++i) {
        [$array addObjects:$values];
    }

    { ^nl NSUInteger i = 0; ^nl NSArray *values = $values; ^nl for (id value in $array) { ^nl XCTAssertEqualObjects(values[i++ % values.count], value); ^nl } ^nl XCTAssertEqual(i, $array.count); ^nl } ^nl 
}

- (void)testUnmanagedFastEnumerationWithMutation {
    // this is sort of an open question
}

- (void)testUnmanagedValueForKey {
    XCTAssertEqualObjects([$array valueForKey:@"self"], @[]);

    [$array addObjects:$values];

    XCTAssertEqualObjects([$array valueForKey:@"self"], ($values));

    RLMAssertThrowsWithReason([$array valueForKey:@"count"], ^n @"this class is not key value coding-compliant for the key count");
}

- (void)testUnmanagedSetValueForKey {
    RLMAssertThrowsWithReason([$array setValue:@0 forKey:@"not self"], ^n @"idk");
    RLMAssertThrowsWithReason([$array setValue:$wrong forKey:@"self"], ^n @"Invalid value '$wdesc' of type '$wtype' for expected type '$type'");
    %r RLMAssertThrowsWithReason([$array setValue:NSNull.null forKey:@"self"], ^n @"Invalid value '<null>' of type 'NSNull' for expected type '$type'");

    [$array addObjects:$values];

    [$array setValue:$v0 forKey:@"self"];

    XCTAssertEqualObjects($array[0], $v0);
    XCTAssertEqualObjects($array[1], $v0);
    %o XCTAssertEqualObjects($array[2], $v0);

    %o [$array setValue:NSNull.null forKey:@"self"];
    %o XCTAssertEqualObjects($array[0], NSNull.null);
}

- (void)testUnmanagedAssignment {
    $array = (id)$values; ^nl XCTAssertEqualObjects([$array valueForKey:@"self"], ($values)); ^nl 

    $array = $array; ^nl XCTAssertEqualObjects([$array valueForKey:@"self"], ($values)); ^nl 
}

- (void)testUnmanagedDescription {

}

#pragma mark - Managed

#if 0
- (void)testUnmanagedArrayCanOutliveParentObject {
    RLMArray *array;
    @autoreleasepool {
        ArrayPropertyObject *arObj = [[ArrayPropertyObject alloc] initWithValue:@[@"arrayObject", @[@[@"a"]], @[]]];
        array = arObj.array;
        XCTAssertFalse(array.isInvalidated, @"stringArray should be valid after creation.");
        arObj = nil;
    }
    XCTAssertFalse(array.isInvalidated, @"stringArray should still be valid after parent deletion.");
}

- (void)testDeleteObjectWithArrayProperty {
    RLMRealm *realm = [self realmWithTestPath];

    [realm beginWriteTransaction];
    ArrayPropertyObject *arObj = [ArrayPropertyObject createInRealm:realm withValue:@[@"arrayObject", @[@[@"a"]], @[]]];
    RLMArray *stringArray = arObj.array;
    XCTAssertFalse(stringArray.isInvalidated, @"stringArray should be valid after creation.");
    [realm deleteObject:arObj];
    XCTAssertTrue(stringArray.isInvalidated, @"stringArray should be invalid after parent deletion.");
    [realm commitWriteTransaction];
}

- (void)testDeleteObjectInArrayProperty {
    RLMRealm *realm = [self realmWithTestPath];

    [realm beginWriteTransaction];
    ArrayPropertyObject *arObj = [ArrayPropertyObject createInRealm:realm withValue:@[@"arrayObject", @[@[@"a"]], @[]]];
    RLMArray *stringArray = arObj.array;
    StringObject *firstObject = stringArray.firstObject;
    [realm deleteObjects:[StringObject allObjectsInRealm:realm]];
    XCTAssertFalse(stringArray.isInvalidated, @"stringArray should be valid after member object deletion.");
    XCTAssertTrue(firstObject.isInvalidated, @"firstObject should be invalid after deletion.");
    XCTAssertEqual(stringArray.count, 0U, @"stringArray.count should be zero after deleting its only member.");
    [realm commitWriteTransaction];
}

- (void)testModifyDuringEnumeration {
    RLMRealm *realm = self.realmWithTestPath;

    [realm beginWriteTransaction];
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    [realm addObject:company];

    const size_t totalCount = 40;
    for (size_t i = 0; i < totalCount; ++i) {
        [company.employees addObject:[EmployeeObject createInRealm:realm withValue:@[@"name", @(i), @NO]]];
    }

    size_t count = 0;
    for (EmployeeObject *eo in company.employees) {
        ++count;
        [company.employees addObject:eo];
    }
    XCTAssertEqual(totalCount, count);
    XCTAssertEqual(totalCount * 2, company.employees.count);

    [realm cancelWriteTransaction];

    // Unmanaged array
    company = [[CompanyObject alloc] init];
    for (size_t i = 0; i < totalCount; ++i) {
        [company.employees addObject:[[EmployeeObject alloc] initWithValue:@[@"name", @(i), @NO]]];
    }

    count = 0;
    for (EmployeeObject *eo in company.employees) {
        ++count;
        [company.employees addObject:eo];
    }
    XCTAssertEqual(totalCount, count);
    XCTAssertEqual(totalCount * 2, company.employees.count);
}

- (void)testDeleteDuringEnumeration {
    RLMRealm *realm = self.realmWithTestPath;

    [realm beginWriteTransaction];
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    [realm addObject:company];

    const size_t totalCount = 40;
    for (size_t i = 0; i < totalCount; ++i) {
        [company.employees addObject:[EmployeeObject createInRealm:realm withValue:@[@"name", @(i), @NO]]];
    }

    [realm commitWriteTransaction];

    [realm beginWriteTransaction];
    for (__unused EmployeeObject *eo in company.employees) {
        [realm deleteObjects:company.employees];
    }
    [realm commitWriteTransaction];
}

- (void)testValueForKey {
    RLMRealm *realm = self.realmWithTestPath;

    [realm beginWriteTransaction];
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";
    XCTAssertEqualObjects([company.employees valueForKey:@"name"], @[]);
    [realm addObject:company];
    [realm commitWriteTransaction];

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], @[]);

    // managed
    NSMutableArray *ages = [NSMutableArray array];
    [realm beginWriteTransaction];
    for (int i = 0; i < 30; ++i) {
        [ages addObject:@(i)];
        EmployeeObject *eo = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Joe",  @"age": @(i), @"hired": @YES}];
        [company.employees addObject:eo];
    }
    [realm commitWriteTransaction];

    RLM_GENERIC_ARRAY(EmployeeObject) *employeeObjects = [company valueForKey:@"employees"];
    NSMutableArray *kvcAgeProperties = [NSMutableArray array];
    for (EmployeeObject *employee in employeeObjects) {
        [kvcAgeProperties addObject:@(employee.age)];
    }
    XCTAssertEqualObjects(kvcAgeProperties, ages);

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], ages);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] firstObject] isEqualToObject:company.employees.firstObject]);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] lastObject] isEqualToObject:company.employees.lastObject]);

    XCTAssertEqual([[company.employees valueForKeyPath:@"@count"] integerValue], 30);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@min.age"] integerValue], 0);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@max.age"] integerValue], 29);
    XCTAssertEqualWithAccuracy([[company.employees valueForKeyPath:@"@avg.age"] doubleValue], 14.5, 0.1f);

    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@unionOfObjects.age"],
                          (@[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23, @24, @25, @26, @27, @28, @29]));
    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@distinctUnionOfObjects.name"], (@[@"Joe"]));

    RLMAssertThrowsWithReasonMatching([company.employees valueForKeyPath:@"@sum.dogs.@sum.age"], @"Nested key paths.*not supported");

    // unmanaged object
    company = [[CompanyObject alloc] init];
    ages = [NSMutableArray array];
    for (int i = 0; i < 30; ++i) {
        [ages addObject:@(i)];
        EmployeeObject *eo = [[EmployeeObject alloc] initWithValue:@{@"name": @"Joe",  @"age": @(i), @"hired": @YES}];
        [company.employees addObject:eo];
    }

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], ages);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] firstObject] isEqualToObject:company.employees.firstObject]);
    XCTAssertTrue([[[company.employees valueForKey:@"self"] lastObject] isEqualToObject:company.employees.lastObject]);

    XCTAssertEqual([[company.employees valueForKeyPath:@"@count"] integerValue], 30);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@min.age"] integerValue], 0);
    XCTAssertEqual([[company.employees valueForKeyPath:@"@max.age"] integerValue], 29);
    XCTAssertEqualWithAccuracy([[company.employees valueForKeyPath:@"@avg.age"] doubleValue], 14.5, 0.1f);

    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@unionOfObjects.age"],
                          (@[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23, @24, @25, @26, @27, @28, @29]));
    XCTAssertEqualObjects([company.employees valueForKeyPath:@"@distinctUnionOfObjects.name"], (@[@"Joe"]));

    RLMAssertThrowsWithReasonMatching([company.employees valueForKeyPath:@"@sum.dogs.@sum.age"], @"Nested key paths.*not supported");
}

- (void)testSetValueForKey {
    RLMRealm *realm = self.realmWithTestPath;

    [realm beginWriteTransaction];
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";

    [company.employees setValue:@"name" forKey:@"name"];
    XCTAssertEqualObjects([company.employees valueForKey:@"name"], @[]);

    [realm addObject:company];
    [realm commitWriteTransaction];

    XCTAssertThrows([company.employees setValue:@10 forKey:@"age"]);
    XCTAssertEqualObjects([company.employees valueForKey:@"age"], @[]);

    // managed
    NSMutableArray *ages = [NSMutableArray array];
    [realm beginWriteTransaction];
    for (int i = 0; i < 30; ++i) {
        [ages addObject:@(20)];
        EmployeeObject *eo = [EmployeeObject createInRealm:realm withValue:@{@"name": @"Joe",  @"age": @(i), @"hired": @YES}];
        [company.employees addObject:eo];
    }

    [company.employees setValue:@20 forKey:@"age"];
    [realm commitWriteTransaction];

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], ages);

    // unmanaged object
    company = [[CompanyObject alloc] init];
    ages = [NSMutableArray array];
    for (int i = 0; i < 30; ++i) {
        [ages addObject:@(20)];
        EmployeeObject *eo = [[EmployeeObject alloc] initWithValue:@{@"name": @"Joe",  @"age": @(i), @"hired": @YES}];
        [company.employees addObject:eo];
    }

    [company.employees setValue:@20 forKey:@"age"];

    XCTAssertEqualObjects([company.employees valueForKey:@"age"], ages);
}

- (void)testObjectAggregate {
    RLMRealm *realm = [RLMRealm defaultRealm];

    AggregateArrayObject *obj = [AggregateArrayObject new];
    XCTAssertEqual(0, [obj.array sumOfProperty:@"intCol"].intValue);
    XCTAssertNil([obj.array averageOfProperty:@"intCol"]);
    XCTAssertNil([obj.array minOfProperty:@"intCol"]);
    XCTAssertNil([obj.array maxOfProperty:@"intCol"]);

    NSDate *dateMinInput = [NSDate date];
    NSDate *dateMaxInput = [dateMinInput dateByAddingTimeInterval:1000];

    [realm transactionWithBlock:^{
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];
        [AggregateObject createInRealm:realm withValue:@[@1, @0.0f, @2.5, @NO, dateMaxInput]];
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];
        [AggregateObject createInRealm:realm withValue:@[@1, @0.0f, @2.5, @NO, dateMaxInput]];
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];
        [AggregateObject createInRealm:realm withValue:@[@1, @0.0f, @2.5, @NO, dateMaxInput]];
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];
        [AggregateObject createInRealm:realm withValue:@[@1, @0.0f, @2.5, @NO, dateMaxInput]];
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];
        [AggregateObject createInRealm:realm withValue:@[@0, @1.2f, @0.0, @YES, dateMinInput]];

        [obj.array addObjects:[AggregateObject allObjectsInRealm:realm]];
    }];

    void (^test)(void) = ^{
        RLMArray *array = obj.array;

        // SUM
        XCTAssertEqual([array sumOfProperty:@"intCol"].integerValue, 4);
        XCTAssertEqualWithAccuracy([array sumOfProperty:@"floatCol"].floatValue, 7.2f, 0.1f);
        XCTAssertEqualWithAccuracy([array sumOfProperty:@"doubleCol"].doubleValue, 10.0, 0.1f);
        RLMAssertThrowsWithReasonMatching([array sumOfProperty:@"foo"], @"foo.*AggregateObject");
        RLMAssertThrowsWithReasonMatching([array sumOfProperty:@"boolCol"], @"sum.*bool");
        RLMAssertThrowsWithReasonMatching([array sumOfProperty:@"dateCol"], @"sum.*date");

        // Average
        XCTAssertEqualWithAccuracy([array averageOfProperty:@"intCol"].doubleValue, 0.4, 0.1f);
        XCTAssertEqualWithAccuracy([array averageOfProperty:@"floatCol"].doubleValue, 0.72, 0.1f);
        XCTAssertEqualWithAccuracy([array averageOfProperty:@"doubleCol"].doubleValue, 1.0, 0.1f);
        RLMAssertThrowsWithReasonMatching([array averageOfProperty:@"foo"], @"foo.*AggregateObject");
        RLMAssertThrowsWithReasonMatching([array averageOfProperty:@"boolCol"], @"average.*bool");
        RLMAssertThrowsWithReasonMatching([array averageOfProperty:@"dateCol"], @"average.*date");

        // MIN
        XCTAssertEqual(0, [[array minOfProperty:@"intCol"] intValue]);
        XCTAssertEqual(0.0f, [[array minOfProperty:@"floatCol"] floatValue]);
        XCTAssertEqual(0.0, [[array minOfProperty:@"doubleCol"] doubleValue]);
        XCTAssertEqualObjects(dateMinInput, [array minOfProperty:@"dateCol"]);
        RLMAssertThrowsWithReasonMatching([array minOfProperty:@"foo"], @"foo.*AggregateObject");
        RLMAssertThrowsWithReasonMatching([array minOfProperty:@"boolCol"], @"min.*bool");

        // MAX
        XCTAssertEqual(1, [[array maxOfProperty:@"intCol"] intValue]);
        XCTAssertEqual(1.2f, [[array maxOfProperty:@"floatCol"] floatValue]);
        XCTAssertEqual(2.5, [[array maxOfProperty:@"doubleCol"] doubleValue]);
        XCTAssertEqualObjects(dateMaxInput, [array maxOfProperty:@"dateCol"]);
        RLMAssertThrowsWithReasonMatching([array maxOfProperty:@"foo"], @"foo.*AggregateObject");
        RLMAssertThrowsWithReasonMatching([array maxOfProperty:@"boolCol"], @"max.*bool");
    };

    test();
    [realm transactionWithBlock:^{ [realm addObject:obj]; }];
    test();
}

- (void)testValueForCollectionOperationKeyPath {
    RLMRealm *realm = [RLMRealm defaultRealm];

    [realm beginWriteTransaction];
    EmployeeObject *e1 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"A", @"age": @20, @"hired": @YES}];
    EmployeeObject *e2 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"B", @"age": @30, @"hired": @NO}];
    EmployeeObject *e3 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"C", @"age": @40, @"hired": @YES}];
    EmployeeObject *e4 = [PrimaryEmployeeObject createInRealm:realm withValue:@{@"name": @"D", @"age": @50, @"hired": @YES}];
    PrimaryCompanyObject *c1 = [PrimaryCompanyObject createInRealm:realm withValue:@{@"name": @"ABC AG", @"employees": @[e1, e2, e3, e2]}];
    PrimaryCompanyObject *c2 = [PrimaryCompanyObject createInRealm:realm withValue:@{@"name": @"ABC AG 2", @"employees": @[e1, e4]}];

    ArrayOfPrimaryCompanies *companies = [ArrayOfPrimaryCompanies createInRealm:realm withValue:@[@[c1, c2]]];
    [realm commitWriteTransaction];

    // count operator
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@count"] integerValue], 4);

    // numeric operators
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@min.age"] intValue], 20);
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@max.age"] intValue], 40);
    XCTAssertEqual([[c1.employees valueForKeyPath:@"@sum.age"] integerValue], 120);
    XCTAssertEqualWithAccuracy([[c1.employees valueForKeyPath:@"@avg.age"] doubleValue], 30, 0.1f);

    // collection
    XCTAssertEqualObjects([c1.employees valueForKeyPath:@"@unionOfObjects.name"],
                          (@[@"A", @"B", @"C", @"B"]));
    XCTAssertEqualObjects([[c1.employees valueForKeyPath:@"@distinctUnionOfObjects.name"] sortedArrayUsingSelector:@selector(compare:)],
                          (@[@"A", @"B", @"C"]));
    XCTAssertEqualObjects([companies.companies valueForKeyPath:@"@unionOfArrays.employees"],
                          (@[e1, e2, e3, e2, e1, e4]));
    NSComparator cmp = ^NSComparisonResult(id obj1, id obj2) { return [[obj1 name] compare:[obj2 name]]; };
    XCTAssertEqualObjects([[companies.companies valueForKeyPath:@"@distinctUnionOfArrays.employees"] sortedArrayUsingComparator:cmp],
                          (@[e1, e2, e3, e4]));

    // invalid key paths
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@invalid.name"],
                                      @"Unsupported KVC collection operator found in key path '@invalid.name'");
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@sum"],
                                      @"Missing key path for KVC collection operator sum in key path '@sum'");
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@sum."],
                                      @"Missing key path for KVC collection operator sum in key path '@sum.'");
    RLMAssertThrowsWithReasonMatching([c1.employees valueForKeyPath:@"@sum.employees.@sum.age"],
                                      @"Nested key paths.*not supported");
}

- (void)testCrossThreadAccess {
    CompanyObject *company = [[CompanyObject alloc] init];
    company.name = @"name";

    EmployeeObject *eo = [[EmployeeObject alloc] init];
    eo.name = @"Joe";
    eo.age = 40;
    eo.hired = YES;
    [company.employees addObject:eo];
    RLMArray *employees = company.employees;

    // Unmanaged object can be accessed from other threads
    [self dispatchAsyncAndWait:^{
        XCTAssertNoThrow(company.employees);
        XCTAssertNoThrow([employees lastObject]);
    }];

    [RLMRealm.defaultRealm beginWriteTransaction];
    [RLMRealm.defaultRealm addObject:company];
    [RLMRealm.defaultRealm commitWriteTransaction];

    employees = company.employees;
    XCTAssertNoThrow(company.employees);
    XCTAssertNoThrow([employees lastObject]);
    [self dispatchAsyncAndWait:^{
        XCTAssertThrows(company.employees);
        XCTAssertThrows([employees lastObject]);
    }];
}

- (void)testSortByNoColumns {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    DogObject *a2 = [DogObject createInDefaultRealmWithValue:@[@"a", @2]];
    DogObject *b1 = [DogObject createInDefaultRealmWithValue:@[@"b", @1]];
    DogObject *a1 = [DogObject createInDefaultRealmWithValue:@[@"a", @1]];
    DogObject *b2 = [DogObject createInDefaultRealmWithValue:@[@"b", @2]];

    RLMArray<DogObject *> *array = [DogArrayObject createInDefaultRealmWithValue:@[@[a2, b1, a1, b2]]].dogs;
    [realm commitWriteTransaction];

    RLMResults *notActuallySorted = [array sortedResultsUsingDescriptors:@[]];
    XCTAssertTrue([array[0] isEqualToObject:notActuallySorted[0]]);
    XCTAssertTrue([array[1] isEqualToObject:notActuallySorted[1]]);
    XCTAssertTrue([array[2] isEqualToObject:notActuallySorted[2]]);
    XCTAssertTrue([array[3] isEqualToObject:notActuallySorted[3]]);
}

- (void)testSortByMultipleColumns {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    DogObject *a1 = [DogObject createInDefaultRealmWithValue:@[@"a", @1]];
    DogObject *a2 = [DogObject createInDefaultRealmWithValue:@[@"a", @2]];
    DogObject *b1 = [DogObject createInDefaultRealmWithValue:@[@"b", @1]];
    DogObject *b2 = [DogObject createInDefaultRealmWithValue:@[@"b", @2]];

    DogArrayObject *array = [DogArrayObject createInDefaultRealmWithValue:@[@[a1, a2, b1, b2]]];
    [realm commitWriteTransaction];

    bool (^checkOrder)(NSArray *, NSArray *, NSArray *) = ^bool(NSArray *properties, NSArray *ascending, NSArray *dogs) {
        NSArray *sort = @[[RLMSortDescriptor sortDescriptorWithKeyPath:properties[0] ascending:[ascending[0] boolValue]],
                          [RLMSortDescriptor sortDescriptorWithKeyPath:properties[1] ascending:[ascending[1] boolValue]]];
        RLMResults *actual = [array.dogs sortedResultsUsingDescriptors:sort];

        return [actual[0] isEqualToObject:dogs[0]]
            && [actual[1] isEqualToObject:dogs[1]]
            && [actual[2] isEqualToObject:dogs[2]]
            && [actual[3] isEqualToObject:dogs[3]];
    };

    // Check each valid sort
    XCTAssertTrue(checkOrder(@[@"dogName", @"age"], @[@YES, @YES], @[a1, a2, b1, b2]));
    XCTAssertTrue(checkOrder(@[@"dogName", @"age"], @[@YES, @NO], @[a2, a1, b2, b1]));
    XCTAssertTrue(checkOrder(@[@"dogName", @"age"], @[@NO, @YES], @[b1, b2, a1, a2]));
    XCTAssertTrue(checkOrder(@[@"dogName", @"age"], @[@NO, @NO], @[b2, b1, a2, a1]));
    XCTAssertTrue(checkOrder(@[@"age", @"dogName"], @[@YES, @YES], @[a1, b1, a2, b2]));
    XCTAssertTrue(checkOrder(@[@"age", @"dogName"], @[@YES, @NO], @[b1, a1, b2, a2]));
    XCTAssertTrue(checkOrder(@[@"age", @"dogName"], @[@NO, @YES], @[a2, b2, a1, b1]));
    XCTAssertTrue(checkOrder(@[@"age", @"dogName"], @[@NO, @NO], @[b2, a2, b1, a1]));
}

- (void)testArrayDescription {
    RLMRealm *realm = [RLMRealm defaultRealm];

    [realm beginWriteTransaction];
    RLMArray<EmployeeObject *> *employees = [CompanyObject createInDefaultRealmWithValue:@[@"company"]].employees;
    RLMArray<NSNumber *> *ints = [AllPrimitiveArrays createInDefaultRealmWithValue:@[]].intObj;
    for (NSInteger i = 0; i < 1012; ++i) {
        EmployeeObject *person = [[EmployeeObject alloc] init];
        person.name = @"Mary";
        person.age = 24;
        person.hired = YES;
        [employees addObject:person];
        [ints addObject:@(i + 100)];
    }
    [realm commitWriteTransaction];

    RLMAssertMatches(employees.description,
                     @"(?s)RLMArray\\<EmployeeObject\\> \\<0x[a-z0-9]+\\> \\(\n"
                     @"\t\\[0\\] EmployeeObject \\{\n"
                     @"\t\tname = Mary;\n"
                     @"\t\tage = 24;\n"
                     @"\t\thired = 1;\n"
                     @"\t\\},\n"
                     @".*\n"
                     @"\t... 912 objects skipped.\n"
                     @"\\)");
    RLMAssertMatches(ints.description,
                     @"(?s)RLMArray\\<int\\> \\<0x[a-z0-9]+\\> \\(\n"
                     @"\t\\[0\\] 100,\n"
                     @"\t\\[1\\] 101,\n"
                     @"\t\\[2\\] 102,\n"
                     @".*\n"
                     @"\t... 912 objects skipped.\n"
                     @"\\)");
}

- (void)testAssignIncorrectType {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm
                                                          withValue:@[@"", @[@[@"a"]], @[@[@0]]]];
    RLMAssertThrowsWithReason(array.intArray = (id)array.array,
                              @"Object of type (StringObject) does not match List type");
    RLMAssertThrowsWithReason(array[@"intArray"] = array[@"array"],
                              @"Invalid property value");
    [realm cancelWriteTransaction];
}

- (void)testNotificationSentInitially {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
    [realm commitWriteTransaction];

    id expectation = [self expectationWithDescription:@""];
    id token = [array.array addNotificationBlock:^(RLMArray *array, RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssertNil(change);
        XCTAssertNil(error);
        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:2.0 handler:nil];
    [(RLMNotificationToken *)token stop];
}

- (void)testNotificationSentAfterCommit {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
    [realm commitWriteTransaction];

    __block bool first = true;
    __block id expectation = [self expectationWithDescription:@""];
    id token = [array.array addNotificationBlock:^(RLMArray *array, RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssert(first ? !change : !!change);
        XCTAssertNil(error);
        first = false;
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    expectation = [self expectationWithDescription:@""];
    [self dispatchAsyncAndWait:^{
        RLMRealm *realm = self.realmWithTestPath;
        [realm transactionWithBlock:^{
            RLMArray *array = [(ArrayPropertyObject *)[ArrayPropertyObject allObjectsInRealm:realm].firstObject array];
            [array addObject:[[StringObject alloc] init]];
        }];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    [(RLMNotificationToken *)token stop];
}

- (void)testNotificationNotSentForUnrelatedChange {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
    [realm commitWriteTransaction];

    id expectation = [self expectationWithDescription:@""];
    id token = [array.array addNotificationBlock:^(__unused RLMArray *array, __unused RLMCollectionChange *change, __unused NSError *error) {
        // will throw if it's incorrectly called a second time due to the
        // unrelated write transaction
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    // All notification blocks are called as part of a single runloop event, so
    // waiting for this one also waits for the above one to get a chance to run
    [self waitForNotification:RLMRealmDidChangeNotification realm:realm block:^{
        [self dispatchAsyncAndWait:^{
            RLMRealm *realm = self.realmWithTestPath;
            [realm transactionWithBlock:^{
                [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
            }];
        }];
    }];
    [(RLMNotificationToken *)token stop];
}

- (void)testNotificationSentOnlyForActualRefresh {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
    [realm commitWriteTransaction];

    __block id expectation = [self expectationWithDescription:@""];
    id token = [array.array addNotificationBlock:^(RLMArray *array, __unused RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssertNil(error);
        // will throw if it's called a second time before we create the new
        // expectation object immediately before manually refreshing
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    // Turn off autorefresh, so the background commit should not result in a notification
    realm.autorefresh = NO;

    // All notification blocks are called as part of a single runloop event, so
    // waiting for this one also waits for the above one to get a chance to run
    [self waitForNotification:RLMRealmRefreshRequiredNotification realm:realm block:^{
        [self dispatchAsyncAndWait:^{
            RLMRealm *realm = self.realmWithTestPath;
            [realm transactionWithBlock:^{
                RLMArray *array = [(ArrayPropertyObject *)[ArrayPropertyObject allObjectsInRealm:realm].firstObject array];
                [array addObject:[[StringObject alloc] init]];
            }];
        }];
    }];

    expectation = [self expectationWithDescription:@""];
    [realm refresh];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    [(RLMNotificationToken *)token stop];
}

- (void)testDeletingObjectWithNotificationsRegistered {
    RLMRealm *realm = self.realmWithTestPath;
    [realm beginWriteTransaction];
    ArrayPropertyObject *array = [ArrayPropertyObject createInRealm:realm withValue:@[@"", @[], @[]]];
    [realm commitWriteTransaction];

    __block id expectation = [self expectationWithDescription:@""];
    id token = [array.array addNotificationBlock:^(RLMArray *array, __unused RLMCollectionChange *change, NSError *error) {
        XCTAssertNotNil(array);
        XCTAssertNil(error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2.0 handler:nil];

    [realm beginWriteTransaction];
    [realm deleteObject:array];
    [realm commitWriteTransaction];

    [(RLMNotificationToken *)token stop];
}

- (void)testAllMethodsCheckThread {
    RLMRealm *realm = [RLMRealm defaultRealm];
    __block IntObject *io;
    __block RLMArray *array;
    [realm transactionWithBlock:^{
        io = [IntObject createInDefaultRealmWithValue:@[@0]];
        ArrayPropertyObject *obj = [ArrayPropertyObject createInDefaultRealmWithValue:@[@"", @[], @[io]]];
        array = obj.intArray;
    }];
    [realm beginWriteTransaction];

    [self dispatchAsyncAndWait:^{
        RLMAssertThrowsWithReasonMatching([array count], @"thread");
        RLMAssertThrowsWithReasonMatching([array objectAtIndex:0], @"thread");
        RLMAssertThrowsWithReasonMatching([array firstObject], @"thread");
        RLMAssertThrowsWithReasonMatching([array lastObject], @"thread");

        RLMAssertThrowsWithReasonMatching([array addObject:io], @"thread");
        RLMAssertThrowsWithReasonMatching([array addObjects:@[io]], @"thread");
        RLMAssertThrowsWithReasonMatching([array insertObject:io atIndex:0], @"thread");
        RLMAssertThrowsWithReasonMatching([array removeObjectAtIndex:0], @"thread");
        RLMAssertThrowsWithReasonMatching([array removeLastObject], @"thread");
        RLMAssertThrowsWithReasonMatching([array removeAllObjects], @"thread");
        RLMAssertThrowsWithReasonMatching([array replaceObjectAtIndex:0 withObject:io], @"thread");
        RLMAssertThrowsWithReasonMatching([array moveObjectAtIndex:0 toIndex:1], @"thread");
        RLMAssertThrowsWithReasonMatching([array exchangeObjectAtIndex:0 withObjectAtIndex:1], @"thread");

        RLMAssertThrowsWithReasonMatching([array indexOfObject:[IntObject allObjects].firstObject], @"thread");
        RLMAssertThrowsWithReasonMatching([array indexOfObjectWhere:@"intCol = 0"], @"thread");
        RLMAssertThrowsWithReasonMatching([array indexOfObjectWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]], @"thread");
        RLMAssertThrowsWithReasonMatching([array objectsWhere:@"intCol = 0"], @"thread");
        RLMAssertThrowsWithReasonMatching([array objectsWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]], @"thread");
        RLMAssertThrowsWithReasonMatching([array sortedResultsUsingKeyPath:@"intCol" ascending:YES], @"thread");
        RLMAssertThrowsWithReasonMatching([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"intCol" ascending:YES]]], @"thread");
        RLMAssertThrowsWithReasonMatching(array[0], @"thread");
        RLMAssertThrowsWithReasonMatching(array[0] = io, @"thread");
        RLMAssertThrowsWithReasonMatching([array valueForKey:@"intCol"], @"thread");
        RLMAssertThrowsWithReasonMatching([array setValue:@1 forKey:@"intCol"], @"thread");
        RLMAssertThrowsWithReasonMatching({for (__unused id obj in array);}, @"thread");
    }];
    [realm cancelWriteTransaction];
}

- (void)testAllMethodsCheckForInvalidation {
    RLMRealm *realm = [RLMRealm defaultRealm];
    __block IntObject *io;
    __block RLMArray *array;
    [realm transactionWithBlock:^{
        io = [IntObject createInDefaultRealmWithValue:@[@0]];
        ArrayPropertyObject *obj = [ArrayPropertyObject createInDefaultRealmWithValue:@[@"", @[], @[io]]];
        array = obj.intArray;
    }];

    [realm beginWriteTransaction];

    XCTAssertNoThrow([array objectClassName]);
    XCTAssertNoThrow([array realm]);
    XCTAssertNoThrow([array isInvalidated]);

    XCTAssertNoThrow([array count]);
    XCTAssertNoThrow([array objectAtIndex:0]);
    XCTAssertNoThrow([array firstObject]);
    XCTAssertNoThrow([array lastObject]);

    XCTAssertNoThrow([array addObject:io]);
    XCTAssertNoThrow([array addObjects:@[io]]);
    XCTAssertNoThrow([array insertObject:io atIndex:0]);
    XCTAssertNoThrow([array removeObjectAtIndex:0]);
    XCTAssertNoThrow([array removeLastObject]);
    XCTAssertNoThrow([array removeAllObjects]);
    [array addObjects:@[io, io, io]];
    XCTAssertNoThrow([array replaceObjectAtIndex:0 withObject:io]);
    XCTAssertNoThrow([array moveObjectAtIndex:0 toIndex:1]);
    XCTAssertNoThrow([array exchangeObjectAtIndex:0 withObjectAtIndex:1]);

    XCTAssertNoThrow([array indexOfObject:[IntObject allObjects].firstObject]);
    XCTAssertNoThrow([array indexOfObjectWhere:@"intCol = 0"]);
    XCTAssertNoThrow([array indexOfObjectWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]]);
    XCTAssertNoThrow([array objectsWhere:@"intCol = 0"]);
    XCTAssertNoThrow([array objectsWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]]);
    XCTAssertNoThrow([array sortedResultsUsingKeyPath:@"intCol" ascending:YES]);
    XCTAssertNoThrow([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"intCol" ascending:YES]]]);
    XCTAssertNoThrow(array[0]);
    XCTAssertNoThrow(array[0] = io);
    XCTAssertNoThrow([array valueForKey:@"intCol"]);
    XCTAssertNoThrow([array setValue:@1 forKey:@"intCol"]);
    XCTAssertNoThrow({for (__unused id obj in array);});

    [realm cancelWriteTransaction];
    [realm invalidate];
    [realm beginWriteTransaction];
    io = [IntObject createInDefaultRealmWithValue:@[@0]];

    XCTAssertNoThrow([array objectClassName]);
    XCTAssertNoThrow([array realm]);
    XCTAssertNoThrow([array isInvalidated]);

    RLMAssertThrowsWithReasonMatching([array count], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array objectAtIndex:0], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array firstObject], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array lastObject], @"invalidated");

    RLMAssertThrowsWithReasonMatching([array addObject:io], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array addObjects:@[io]], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array insertObject:io atIndex:0], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array removeObjectAtIndex:0], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array removeLastObject], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array removeAllObjects], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array replaceObjectAtIndex:0 withObject:io], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array moveObjectAtIndex:0 toIndex:1], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array exchangeObjectAtIndex:0 withObjectAtIndex:1], @"invalidated");

    RLMAssertThrowsWithReasonMatching([array indexOfObject:[IntObject allObjects].firstObject], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array indexOfObjectWhere:@"intCol = 0"], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array indexOfObjectWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array objectsWhere:@"intCol = 0"], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array objectsWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array sortedResultsUsingKeyPath:@"intCol" ascending:YES], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"intCol" ascending:YES]]], @"invalidated");
    RLMAssertThrowsWithReasonMatching(array[0], @"invalidated");
    RLMAssertThrowsWithReasonMatching(array[0] = io, @"invalidated");
    RLMAssertThrowsWithReasonMatching([array valueForKey:@"intCol"], @"invalidated");
    RLMAssertThrowsWithReasonMatching([array setValue:@1 forKey:@"intCol"], @"invalidated");
    RLMAssertThrowsWithReasonMatching({for (__unused id obj in array);}, @"invalidated");

    [realm cancelWriteTransaction];
}

- (void)testMutatingMethodsCheckForWriteTransaction {
    RLMRealm *realm = [RLMRealm defaultRealm];
    __block IntObject *io;
    __block RLMArray *array;
    [realm transactionWithBlock:^{
        io = [IntObject createInDefaultRealmWithValue:@[@0]];
        ArrayPropertyObject *obj = [ArrayPropertyObject createInDefaultRealmWithValue:@[@"", @[], @[io]]];
        array = obj.intArray;
    }];

    XCTAssertNoThrow([array objectClassName]);
    XCTAssertNoThrow([array realm]);
    XCTAssertNoThrow([array isInvalidated]);

    XCTAssertNoThrow([array count]);
    XCTAssertNoThrow([array objectAtIndex:0]);
    XCTAssertNoThrow([array firstObject]);
    XCTAssertNoThrow([array lastObject]);

    XCTAssertNoThrow([array indexOfObject:[IntObject allObjects].firstObject]);
    XCTAssertNoThrow([array indexOfObjectWhere:@"intCol = 0"]);
    XCTAssertNoThrow([array indexOfObjectWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]]);
    XCTAssertNoThrow([array objectsWhere:@"intCol = 0"]);
    XCTAssertNoThrow([array objectsWithPredicate:[NSPredicate predicateWithFormat:@"intCol = 0"]]);
    XCTAssertNoThrow([array sortedResultsUsingKeyPath:@"intCol" ascending:YES]);
    XCTAssertNoThrow([array sortedResultsUsingDescriptors:@[[RLMSortDescriptor sortDescriptorWithKeyPath:@"intCol" ascending:YES]]]);
    XCTAssertNoThrow(array[0]);
    XCTAssertNoThrow([array valueForKey:@"intCol"]);
    XCTAssertNoThrow({for (__unused id obj in array);});


    RLMAssertThrowsWithReasonMatching([array addObject:io], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array addObjects:@[io]], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array insertObject:io atIndex:0], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array removeObjectAtIndex:0], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array removeLastObject], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array removeAllObjects], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array replaceObjectAtIndex:0 withObject:io], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array moveObjectAtIndex:0 toIndex:1], @"write transaction");
    RLMAssertThrowsWithReasonMatching([array exchangeObjectAtIndex:0 withObjectAtIndex:1], @"write transaction");

    RLMAssertThrowsWithReasonMatching(array[0] = io, @"write transaction");
    RLMAssertThrowsWithReasonMatching([array setValue:@1 forKey:@"intCol"], @"write transaction");
}
#endif
@end
