#!/usr/bin/env python3
# Python program to check the results of the cloud-init-creator tests
import sys
import os.path

RED = "\033[1;31m"
GREEN = "\033[0;32m"
RESET = "\033[0;0m"

containerLogTests = [
    {
        'description': "Should return error message when no files are provided",
        'file': "test-results/cic-fail-no-files.txt",
        'expected': "No user-data file provided!!"
    },
    {
        'description': "Should return error message when meta-data file is provided but no user-data file is provided",
        'file': "test-results/cic-fail-no-user-data.txt",
        'expected': "No user-data file provided!!"
    },
    {
        'description': "Should return success message when user-data file is provided",
        'file': "test-results/cic-succeed-user-data.txt",
        'expected': "wrote /usr/src/files/config-data.iso with filesystem=iso9660 and diskformat=raw"
    },
    {
        'description': "Should return success message when user-data and meta-data files are provided",
        'file': "test-results/cic-succeed-both-files.txt",
        'expected': "wrote /usr/src/files/config-data.iso with filesystem=iso9660 and diskformat=raw"
    }
]

print("\nContainer Log Tests:")
for test in containerLogTests:
    containerLog = open(test['file'], 'r').read().replace('\n', '')
    if containerLog == test['expected']:
        sys.stdout.write(GREEN + "SUCCESS : " + RESET + test['description'] + "\n")
    else:
        sys.stdout.write(RED + "FAILED! : " + RESET + test['description'] + RED +
                         "\n    Expected : " + test['expected'] + "\n    Got      : " + containerLog)
        sys.stdout.write(RESET + "\n")


isoFileTests = [
    {
        'description': "Should NOT return a cloud-init.iso file when no files are provided",
        'file': "fail-no-files/config-data.iso",
        'expectedExistence': False,
        'sizeTestDescription': "config-data.iso should match the expected file size",
        'expectedSize': 0
    },
    {
        'description': "Should NOT return a cloud-init.iso file when meta-data file is provided but no user-data file is provided",
        'file': "fail-no-user-data/config-data.iso",
        'expectedExistence': False,
        'sizeTestDescription': "config-data.iso should match the expected file size",
        'expectedSize': 0
    },
    {
        'description': "Should return iso file when user-data file is provided",
        'file': "succeed-user-data/config-data.iso",
        'expectedExistence': True,
        'sizeTestDescription': "Config-data.iso should match the expected file size",
        'expectedSize': 374784
    },
    {
        'description': "Should return iso file when user-data and meta-data files are provided",
        'file': "succeed-both-files/config-data.iso",
        'expectedExistence': True,
        'sizeTestDescription': "Config-data.iso should match the expected file size",
        'expectedSize': 374784
    }
]

print("\nISO File Tests:")
for test in isoFileTests:
    fileExists=os.path.exists(test['file']) and os.path.isfile(test['file'])
    if fileExists == test['expectedExistence']:
        sys.stdout.write(GREEN + "SUCCESS : " + RESET + test['description'] + "\n")
        if fileExists:
            fileSize = os.path.getsize(test['file'])
            if fileSize == test['expectedSize']:
                sys.stdout.write(GREEN + "SUCCESS : " + RESET + test['sizeTestDescription'] + "\n")
            else:
                sys.stdout.write(RED + "FAILED! : " + RESET + test['sizeTestDescription'] + RED +
                                 "\n    Expected Size : " + str(test['expectedSize']) +
                                 "\n              Got : " + str(fileSize))
                sys.stdout.write(RESET + "\n")
    else:
        sys.stdout.write(RED + "FAILED! : " + RESET + test['description'] + RED +
                         "\n    Expected File Exists : " + str(test['expectedExistence']) +
                         "\n                     Got : " + str(fileExists))
        sys.stdout.write(RESET + "\n")

print("\nTests Complete!\n")
