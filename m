Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-io1-f50.google.com ([209.85.166.50]:35943 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeJEJJe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Oct 2018 05:09:34 -0400
Received: by mail-io1-f50.google.com with SMTP id p4-v6so9550455iom.3
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Oct 2018 19:13:05 -0700 (PDT)
MIME-Version: 1.0
From: Anup Pemmaiah <anup.pemmaiah@gmail.com>
Date: Thu, 4 Oct 2018 19:12:53 -0700
Message-ID: <CAF_EZTMMAkxfCxjAVTJCqVHTUbPQNyUXDgbDk8xmGvp-hKdwcQ@mail.gmail.com>
Subject: Floating point register corruption on ARM Cortex A57 (ARMv8) with
 RT_PREEMPT linux
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hi,

I have a multi threaded userspace application running on RT_PREEMPT
linux on ARM Cortex A57 (ARMv8). The linux version is 4.14.0 with the
corresponding RT_PREEMPT patch. The below code is a simplified version
to re-create the issue. When the code is compiled with optimization
level -O1 and above, it error's out after sometime, with random value
in fl_val(result of the multiplication in thr_fn) at Line-24. After
looking at the compiled assembly code and through gdb, noticed that,
the value of 0.002 is loaded into a floating point register(s8) before
the looping starts at Line-21. The s8 register value is then used to
multiply with register storing frand value at Line-24. At random
times, the value in s8, has garbage value and the process aborts as
expected. It looks like, during kernel context switches, it is not
properly re-storing the values of floating point registers. The same
code works fine without any errors, on a non-rt kernel of the same
version on the same hardware.

My Questions

1) Is there any floating point related kernel setting that I should
set in the RT_PREEMPT kernel? I have set eagerfpu=on (even though it
is on by default)

2) Was reading about "Lazy Stacking" for Cortex-M4, but not sure if it
applies for Cortex A57

Any comments will be greatly appreciated.

----------------------------------------------Test-code------------------------------------------------------------
  1 #include <iostream>
  2 #include <cstdlib>
  3 #include <cstdint>
  4 #include <ctime>
  5 #include <random>
  6 #include <pthread.h>
  7 #include <string.h>
  8 #include <errno.h>
  9 #include <unistd.h>
 10 #include <signal.h>
 11
 12 #define MAX_THR 30
 13
 14 typedef float float32_t;
 15 int32_t gflag = 0;
 16
 17 void *thr_fn(void *arg) {
 18   //pthread_t cur_tid = pthread_self();
 19   std::random_device rd;   // non-deterministic generator
 20   std::mt19937 gen(rd());
 21   while (1) {
 22     uint32_t rand_num = gen() % 1000;
 23     float32_t frand = static_cast<float32_t>(rand_num);
 24     float32_t fl_val = (frand * 0.002F);
 25     if ((fl_val < 0.0F) || (fl_val > 2.0F)) {
 26       gflag = -1;
 27       // Keep sleeping till the process gets aborted by the main thread
 28       while(1){usleep(2000);}
 29     }
 30     usleep(1000);
 31   }
 32 }
 33
 34 int main() {
 35   int thr_cnt;
 36   int res = 0;
 37   pthread_t tid;
 38   for (thr_cnt = 0; thr_cnt < MAX_THR; thr_cnt++) {
 39     res = pthread_create(&tid,  NULL, thr_fn, NULL);
 40     if (res != 0) {
 41       std::cout <<"Error creating pthread: " <<strerror(errno);
 42     }
 43   }
 44   while(1){
 45     if (gflag != 0) {
 46       kill(getpid(), SIGABRT);
 47     }
 48     usleep(1000 * 1000 * 1);
 49   }
 50   return (0);
 51 }
~
Thanks
Anup
