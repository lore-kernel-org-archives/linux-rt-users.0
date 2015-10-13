From: Christoph Mathys <eraserix@gmail.com>
Subject: [4.1.7-rt8][report] Very high cyclictest latency during glmark2 on
 i915 gpu
Date: Tue, 13 Oct 2015 17:35:54 +0200
Message-ID: <CALqGcGpLJ+x_Gg7i4W4UCe4+GJEfdFNo-UryyOyQZJ1q5AAWJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34420 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbbJMPf4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Oct 2015 11:35:56 -0400
Received: by lbbck17 with SMTP id ck17so25256814lbb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Oct 2015 08:35:54 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When running cyclictest and the opengl benchmark tool glmark2 I see
pretty severe latency spikes of about 1.8 milliseconds with kernel
4.1.7-rt8.

Using the same machine with different RT kernels (also only one testrun)
- 3.12 max latency is 66 microseconds.
- 3.18 max latency is 157 microseconds

The machine in question uses a Core i7-3770 CPU and the Intel i915
kernel driver.

Can anyone reproduce this? Any ideas? dmesg does not contain any funny
reports...

Christoph
