From: Patrick Doyle <wpdster@gmail.com>
Subject: Current Best Practices for accessing PWM devices in real-time
Date: Sat, 30 Dec 2017 17:52:32 -0500
Message-ID: <CAF_dkJBVERqULLKZxA4BqoTsUotrvZyoRwvh-+JJC6mPG08euw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ot0-f173.google.com ([74.125.82.173]:34648 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbdL3WxD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 30 Dec 2017 17:53:03 -0500
Received: by mail-ot0-f173.google.com with SMTP id n18so30703202otd.1
        for <linux-rt-users@vger.kernel.org>; Sat, 30 Dec 2017 14:53:03 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

(I had so much luck with my previous "CBP" query, that I think I'm
going to keep this up).

Many SoC's have general purpose PWM controllers built into the device.

What are the current best practices for accessing PWM controlled
external peripherals (such as motor drivers) from within a real-time
Linux thread?

Do folks primarily access the PWM peripheral via the /sys/class/pwm
interface as described at
https://www.kernel.org/doc/Documentation/pwm.txt?  Doesn't that seem
terribly inefficient?

Do folks write their own "motor control" driver and run them in kernel
context?  Although RT-Linux patches will undoubtedly help this sort of
approach, doesn't that sort of defeat the purpose of real-time Linux
(running real-time code in user space threads)?

Do folks do something completely different?

Again, thanks for tips & pointers.

Stay tuned for my next episode, to be entitled something like "Current
Best Practices for Counting External Events in real-time".  (I'm still
working on a less wordy title.)

--wpd
