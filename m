From: Nicola Manica <nicola.manica@gmail.com>
Subject: info softirq
Date: Wed, 18 Feb 2009 10:47:16 +0100
Message-ID: <30047d300902180147s1bbdbf45u1b194db53c9480a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:54636 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbZBRJrS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2009 04:47:18 -0500
Received: by bwz5 with SMTP id 5so5163501bwz.13
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Feb 2009 01:47:16 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
For my Master thesis I'm testing a module for kernel 2.6.21.4-rt12, so
I need to use this "old" version of kernel.
The kernel is compiled with complete preemption.
I'm testing network interface with netperf.
When I run a simple test I see that most of the time the CPU execute
IRQ-16 (or the one assigned to my eth card) but softirq-net-rx is
never triggered.
If I try the same test with 2.6.24.7-rt24 most of the work is done by
sirq-net-rx.
Maybe I made mistakes somewhere in my configuration.
Could someone give some hints where I have to investigate? Are there
runtime parameters that I can check to see if everything is in order?
Thanks,
Nicola
