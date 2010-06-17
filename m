From: Neel Mehta <neelmehta89@gmail.com>
Subject: Realtime linux kernel on multicore processor
Date: Thu, 17 Jun 2010 14:30:00 +0200
Message-ID: <AANLkTilTcAaRj49CiPgWmPkhWkDkz1CR5sHZygsHRyNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61327 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932768Ab0FQMaV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Jun 2010 08:30:21 -0400
Received: by iwn9 with SMTP id 9so6728170iwn.19
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Jun 2010 05:30:20 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi. I have 2 computers with ubuntu:
1. Core 2 Duo - Non realtime linux kernel
2. Quad core - Realtime linux kernel

Both of them are using ubuntu. I am running a process that generates 2
threads, both of which are continuously processing something.
1. On core 2 duo (normal kernel): both the cores are running above 90% load.
2. on quad core(realtime kernel): only one core runs above 90%, and
the other cores are not at such a high load. The core which is on high
load keeps on alternating among the 4 cores.

So, my question is why doesnt 2 cores run on high load on quad core?
Is there a problem in multiprocessing in realtime linux kernel? Can
someone guide me where the source of problem could be?

Thanks and Regards,
Neel Mehta
Third year Undergraduate student,
Electrical Engineering,
IIT Bombay
