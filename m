Return-Path: <SRS0=4aCa=2B=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65654C43603
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Dec 2019 07:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C82E2053B
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Dec 2019 07:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="CeT9yqng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfLKHSB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:18:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35078 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbfLKHSB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 11 Dec 2019 02:18:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id o9so17933247ote.2
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Dec 2019 23:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=a9q4AwbJfr9pWhp0qfBgTqfbmtLO/ZeQCjoVbcLX/mU=;
        b=CeT9yqng9PG56AXOrWpR/CuW6yBOgAiQsT0qMf8MEyTUrCDn2O5TFrF4eZnfIwYY4d
         HmjrOImy6NWJx6OJSBn1KwloMNRPKxp88yW/cqhd+9QWueA/2TY2skFIwA0kq9yvo89P
         v6CZnUu8iyZVZI+PkjeVwIM/uwMdgemMJ4xyMdjkKOvXipoJddAg7D9BMipXK1e4HpXj
         7s8kjqODQBNLYiM/luC28Tv5GUOQKM7UHkGOZoGqxlk2Bhpo/4t08BE14IYWQ70gtJkt
         27xKr3A6oVY6gaTE0bkwnICwdB9BRb2Z/z0F/sKZcHksYnHhwtDvcToxI90F7fCJfOXc
         LsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a9q4AwbJfr9pWhp0qfBgTqfbmtLO/ZeQCjoVbcLX/mU=;
        b=Ba54PXDp5VGo751EI9x5Ny1jq0rDz70vhZvHl95+Nxc7JeydZXNHm/JHgWx7AdYiz1
         0G0iXmjCUPVFEzKHf+DecBKRhNtYVZYp8G3aOlXHQh0l/SDx+CI/+/74/w2gejwlGixK
         XbZ/cjgZ16MJDobMrAzCLJm2mbOEbssL5cui0r+wTfXRUd7Df4lw7f7D152lW2iSVy0M
         17pKrVjpBP6kK2VKOKKJSM15kuiBYwIzfF4S2tAycUPzQEHuHw5ltGsydLjDOkiz+Cod
         /ncMKWQrwxUCqbHUXMU/bL9CFG2lZd6YFO7Rv7pmV1oHqy4DTt+9FgoKxOyvaGZaufo+
         jnDw==
X-Gm-Message-State: APjAAAW5J3Kfjm6/o46H99bFNcKcYWRb1krtsotW5FveaLgRH4BG82xh
        Xg0Y6Tkk9egGTX7HA9eKJ8kiKnkIpHqx/0HsV541FDOcy/A=
X-Google-Smtp-Source: APXvYqwClN9SeAGIX99t4yIQs4npskw3OgHQ3F1c5+gwwRkggkovTt19+iZLfyXwP7Vl4LetHyFpBTsJBCBj1egDVXo=
X-Received: by 2002:a05:6830:1af8:: with SMTP id c24mr1212540otd.362.1576048679774;
 Tue, 10 Dec 2019 23:17:59 -0800 (PST)
MIME-Version: 1.0
From:   John Mathew <john.mathew@unikie.com>
Date:   Wed, 11 Dec 2019 09:17:49 +0200
Message-ID: <CAJz2qXnHnw7Z9ftb6Oha5_0-R4YfUL+FhVZPNX1KKHyUkP6KNA@mail.gmail.com>
Subject: complete_all() with x waiters in swake_up_all_locked
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

This is a follow up to a previous discussion on this topic:
https://www.spinics.net/lists/linux-rt-users/msg19592.html
https://lkml.org/lkml/2016/3/14/214

We are seeing the waring still appearing in the v5.0.3-rt1 tag of the
rt linux kernel.

The test environment was :QEMU emulator version 2.11.1(Debian
1:2.11+dfsg-1ubuntu7.20)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers


The stack trace is as follows:

553.403374] 001: ------------[ cut here ]------------
[ 553.403826] 001: complete_all() with 4 waiters
[ 553.404205] 001: WARNING: CPU: 1 PID: 10418 at swake_up_all_locked+0x146/0x1e0
[ 553.404806] 001: Modules linked in:
[ 553.405101] 001:
[ 553.405269] 001: CPU: 1 PID: 10418 Comm: cryptomgr_probe Tainted: G
W 5.0.3-rt1-eb-corbos-preempt-rt #5
[ 553.406146] 001: Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[ 553.406914] 001: RIP: 0010:swake_up_all_locked+0x146/0x1e0
[ 553.407373] 001: Code: 0f 85 47 ff ff ff 83 7d cc 02 7f 0f 48 83 c4
18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 8b 75 cc 48 c7 c7 c0 8b a5 94 e8
1a 39 f1 ff <0f> 0b 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 48 8b
7d d0 e8
[ 553.408934] 001: RSP: 0018:ffff888063c37e40 EFLAGS: 00010082
[ 553.409404] 001:
[ 553.409571] 001: RAX: 0000000000000000 RBX: ffff888062b87760 RCX:
ffffffff92c6deb2
[ 553.410195] 001: RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffffffff950c9128
[ 553.410816] 001: RBP: ffff888063c37e80 R08: fffffbfff2a19227 R09:
fffffbfff2a19227
[ 553.411450] 001: R10: 0000000000000001 R11: fffffbfff2a19226 R12:
dffffc0000000000
[ 553.412084] 001: R13: ffff8880612ec1a8 R14: ffff8880612ec1a0 R15:
ffffed100c25d835
[ 553.412709] 001: FS: 0000000000000000(0000)
GS:ffff88806d500000(0000) knlGS:0000000000000000
[ 553.413413] 001: CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 553.413925] 001: CR2: 00007fffab7d4ca0 CR3: 000000000ac12000 CR4:
00000000000006e0
[ 553.414549] 001: DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 553.415172] 001: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[ 553.415798] 001: Call Trace:
[ 553.416043] 001: ? kfree+0xc3/0x210
[ 553.416346] 001: complete_all+0x4c/0x70
[ 553.416676] 001: cryptomgr_probe+0x1af/0x250
[ 553.417041] 001: kthread+0x313/0x3d0
[ 553.417350] 001: ? crypto_alg_put+0x70/0x70
[ 553.417708] 001: ? kthread_park+0x170/0x170
[ 553.418067] 001: ret_from_fork+0x35/0x40
[ 553.418406] 001: ---[ end trace f939e9efc6356ffe ]---

The trigger is from cryptomgr_probe in crypto/algboss.c.

The issue is not seen in plain kernel.

When printing the modules which is waking up and using WARN_ON_ONCE
the output is as follows.

[   18.723634] 000: swake_up_all_locked: 4 wakes done on cpu 0:
cryptomgr_probe (pid: 325)
[   18.724488] 000: WARNING: CPU: 0 PID: 325 at swake_up_all_locked+0x199/0x230
[   18.725212] 000: Modules linked in:
[   18.725501] 000:
[   18.725687] 000: CPU: 0 PID: 325 Comm: cryptomgr_probe Not tainted
5.0.3-rt1-eb-corbos-preempt-rt+ #7
[   18.726436] 000: Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[   18.727197] 000: RIP: 0010:swake_up_all_locked+0x199/0x230
[   18.727652] 000: Code: 0c 25 00 dd 01 00 65 8b 15 54 5a 3c 45 44 8b
83 f0 03 00 00 48 81 c1 98 05 00 00 48 c7 c7 c0 8b a5 bc 8b 75 cc e8
80 16 02 00 <0f> 0b eb 93 48 8b 7d d0 e8 da 55 33 00 e9 71 ff ff ff e8
b0 55 33
[   18.729196] 000: RSP: 0018:ffff888064fb7e40 EFLAGS: 00010082
[   18.729667] 000:
[   18.729833] 000: RAX: 0000000000000046 RBX: ffff8880667ec500 RCX:
ffffffffbac6df02
[   18.730449] 000: RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffffffffbd0c9128
[   18.731063] 000: RBP: ffff888064fb7e80 R08: fffffbfff7a19227 R09:
fffffbfff7a19227
[   18.731677] 000: R10: 0000000000000001 R11: fffffbfff7a19226 R12:
dffffc0000000000
[   18.732291] 000: R13: ffff8880614495b8 R14: ffff8880614495b0 R15:
ffffed100c2892b7
[   18.732906] 000: FS:  0000000000000000(0000)
GS:ffff88806d400000(0000) knlGS:0000000000000000
[   18.733607] 000: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.734111] 000: CR2: 00007ffc43757d9c CR3: 000000006101e000 CR4:
00000000000006f0
[   18.734725] 000: DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   18.735336] 000: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   18.735948] 000: Call Trace:
[   18.736190] 000:  complete_all+0x4c/0x70
[   18.736516] 000:  cryptomgr_probe+0x1af/0x250
[   18.736877] 000:  kthread+0x313/0x3d0
[   18.737181] 000:  ? crypto_alg_put+0x70/0x70
[   18.737533] 000:  ? kthread_park+0x170/0x170
[   18.737890] 000:  ret_from_fork+0x35/0x40
[   18.738226] 000: ---[ end trace 739b32bdb669a874 ]---
[   18.770538] 000: swake_up_all_locked: 3 wakes done on cpu 0:
cryptomgr_probe (pid: 373)
[   18.782207] 001: swake_up_all_locked: 3 wakes done on cpu 1:
cryptomgr_test (pid: 396)
[   18.786154] 001: swake_up_all_locked: 3 wakes done on cpu 1:
cryptomgr_probe (pid: 395)
[   18.798816] 000: swake_up_all_locked: 8 wakes done on cpu 0:
cryptomgr_probe (pid: 407)
[   18.813058] 001: swake_up_all_locked: 3 wakes done on cpu 1:
cryptomgr_probe (pid: 430)
[   18.823554] 000: swake_up_all_locked: 3 wakes done on cpu 0:
cryptomgr_test (pid: 452)
[   18.836808] 001: swake_up_all_locked: 3 wakes done on cpu 1:
cryptomgr_test (pid: 472)
[   18.840767] 001: swake_up_all_locked: 4 wakes done on cpu 1:
cryptomgr_probe (pid: 469)
[   18.852147] 000: swake_up_all_locked: 6 wakes done on cpu 0:
cryptomgr_test (pid: 491)
[   18.871421] 000: swake_up_all_locked: 8 wakes done on cpu 0:
cryptomgr_probe (pid: 508)
[   18.884491] 000: swake_up_all_locked: 4 wakes done on cpu 0:
cryptomgr_test (pid: 529)
[   18.888355] 001: swake_up_all_locked: 4 wakes done on cpu 1:
cryptomgr_probe (pid: 527)
[   18.903979] 001: swake_up_all_locked: 8 wakes done on cpu 1:
cryptomgr_probe (pid: 542)
[   18.920284] 001: swake_up_all_locked: 8 wakes done on cpu 1:
cryptomgr_probe (pid: 566)
[   18.932919] 000: swake_up_all_locked: 6 wakes done on cpu 0:
cryptomgr_probe (pid: 584)
[   18.954440] 001: swake_up_all_locked: 8 wakes done on cpu 1:
cryptomgr_probe (pid: 602)
[   19.003511] 001: swake_up_all_locked: 3 wakes done on cpu 1:
cryptomgr_probe (pid: 652)
[   19.012186] 001: swake_up_all_locked: 3 wakes done on cpu 1:
cryptomgr_probe (pid: 662)

.......

We have 8 syzcaller reproducers with exactly the same warning.

One reproducer is as follows:

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/capability.h>

unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
struct timespec ts;
if (clock_gettime(CLOCK_MONOTONIC, &ts))
exit(1);
return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...)
{
char buf[1024];
va_list args;
va_start(args, what);
vsnprintf(buf, sizeof(buf), what, args);
va_end(args);
buf[sizeof(buf) - 1] = 0;
int len = strlen(buf);
int fd = open(file, O_WRONLY | O_CLOEXEC);
if (fd == -1)
return false;
if (write(fd, buf, len) != len) {
int err = errno;
close(fd);
errno = err;
return false;
}
close(fd);
return true;
}

static void setup_common()
{
if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
}
}

static void loop();

static void sandbox_common()
{
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setpgrp();
setsid();
struct rlimit rlim;
rlim.rlim_cur = rlim.rlim_max = (200 << 20);
setrlimit(RLIMIT_AS, &rlim);
rlim.rlim_cur = rlim.rlim_max = 32 << 20;
setrlimit(RLIMIT_MEMLOCK, &rlim);
rlim.rlim_cur = rlim.rlim_max = 136 << 20;
setrlimit(RLIMIT_FSIZE, &rlim);
rlim.rlim_cur = rlim.rlim_max = 1 << 20;
setrlimit(RLIMIT_STACK, &rlim);
rlim.rlim_cur = rlim.rlim_max = 0;
setrlimit(RLIMIT_CORE, &rlim);
rlim.rlim_cur = rlim.rlim_max = 256;
setrlimit(RLIMIT_NOFILE, &rlim);
if (unshare(CLONE_NEWNS)) {
}
if (unshare(CLONE_NEWIPC)) {
}
if (unshare(0x02000000)) {
}
if (unshare(CLONE_NEWUTS)) {
}
if (unshare(CLONE_SYSVSEM)) {
}
typedef struct {
const char* name;
const char* value;
} sysctl_t;
static const sysctl_t sysctls[] = {
   {"/proc/sys/kernel/shmmax", "16777216"},
   {"/proc/sys/kernel/shmall", "536870912"},
   {"/proc/sys/kernel/shmmni", "1024"},
   {"/proc/sys/kernel/msgmax", "8192"},
   {"/proc/sys/kernel/msgmni", "1024"},
   {"/proc/sys/kernel/msgmnb", "1024"},
   {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
};
unsigned i;
for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
write_file(sysctls[i].name, sysctls[i].value);
}

int wait_for_loop(int pid)
{
if (pid < 0)
exit(1);
int status = 0;
while (waitpid(-1, &status, __WALL) != pid) {
}
return WEXITSTATUS(status);
}

static void drop_caps(void)
{
struct __user_cap_header_struct cap_hdr = {};
struct __user_cap_data_struct cap_data[2] = {};
cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
cap_hdr.pid = getpid();
if (syscall(SYS_capget, &cap_hdr, &cap_data))
exit(1);
const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
cap_data[0].effective &= ~drop;
cap_data[0].permitted &= ~drop;
cap_data[0].inheritable &= ~drop;
if (syscall(SYS_capset, &cap_hdr, &cap_data))
exit(1);
}

static int do_sandbox_none(void)
{
if (unshare(CLONE_NEWPID)) {
}
int pid = fork();
if (pid != 0)
return wait_for_loop(pid);
setup_common();
sandbox_common();
drop_caps();
if (unshare(CLONE_NEWNET)) {
}
loop();
exit(1);
}

static void kill_and_wait(int pid, int* status)
{
kill(-pid, SIGKILL);
kill(pid, SIGKILL);
int i;
for (i = 0; i < 100; i++) {
if (waitpid(-1, status, WNOHANG | __WALL) == pid)
return;
usleep(1000);
}
DIR* dir = opendir("/sys/fs/fuse/connections");
if (dir) {
for (;;) {
struct dirent* ent = readdir(dir);
if (!ent)
break;
if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
continue;
char abort[300];
snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
ent->d_name);
int fd = open(abort, O_WRONLY);
if (fd == -1) {
continue;
}
if (write(fd, abort, 1) < 0) {
}
close(fd);
}
closedir(dir);
} else {
}
while (waitpid(-1, status, __WALL) != pid) {
}
}

static void setup_test()
{
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setpgrp();
write_file("/proc/self/oom_score_adj", "1000");
}

static void close_fds()
{
int fd;
for (fd = 3; fd < 30; fd++)
close(fd);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
int iter;
for (iter = 0;; iter++) {
int pid = fork();
if (pid < 0)
exit(1);
if (pid == 0) {
setup_test();
execute_one();
close_fds();
exit(0);
}
int status = 0;
uint64_t start = current_time_ms();
for (;;) {
if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
break;
sleep_ms(1);
if (current_time_ms() - start < 5 * 1000)
continue;
kill_and_wait(pid, &status);
break;
}
}
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_one(void)
{
intptr_t res = 0;
res = syscall(__NR_socket, 0xf, 3, 2);
if (res != -1)
r[0] = res;
*(uint64_t*)0x20000040 = 0;
*(uint32_t*)0x20000048 = 0;
*(uint64_t*)0x20000050 = 0x20000140;
*(uint64_t*)0x20000140 = 0x200001c0;
*(uint8_t*)0x200001c0 = 2;
*(uint8_t*)0x200001c1 = 7;
*(uint8_t*)0x200001c2 = 0;
*(uint8_t*)0x200001c3 = 0;
*(uint16_t*)0x200001c4 = 2;
*(uint16_t*)0x200001c6 = 0;
*(uint32_t*)0x200001c8 = 0;
*(uint32_t*)0x200001cc = 0;
*(uint64_t*)0x20000148 = 0x10;
*(uint64_t*)0x20000058 = 1;
*(uint64_t*)0x20000060 = 0;
*(uint64_t*)0x20000068 = 0;
*(uint32_t*)0x20000070 = 0;
syscall(__NR_sendmsg, r[0], 0x20000040, 0);

}
int main(void)
{
syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
for (procid = 0; procid < 8; procid++) {
if (fork() == 0) {
do_sandbox_none();
}
}
sleep(1000000);
return 0;
}

Has there been any further investigation in to this warning following
the previous discussion?
-John
