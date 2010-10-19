From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: gdb core dump file truncated.
Date: Tue, 19 Oct 2010 16:28:29 +0530
Message-ID: <AANLkTi=oYXyfE30nj3v51ZP6AgUgzX8ZZ+cwHoW2_ZE3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35827 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644Ab0JSK6a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 Oct 2010 06:58:30 -0400
Received: by iwn7 with SMTP id 7so768590iwn.19
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Oct 2010 03:58:30 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I try to use gdb to debug one application.

Program crashes anf gives a truncated core file of size 2.1 kb.

I did
ulimit -c unlimited

still same problem. Any clue .?
