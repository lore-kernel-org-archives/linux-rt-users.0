From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: tracefs .. idea
Date: Tue, 16 Oct 2012 12:44:50 +0200
Message-ID: <CAF-VNaq+CpDLzLXVg2o2KAZ7fyQfhvxAs6wRWrgvHh3jJ9+2fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:47163 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab2JPKov (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Oct 2012 06:44:51 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1434974eaa.19
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Oct 2012 03:44:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 I was thinking of tracking locks and above all interrupt disable
through debugfs.

 Something along the lines of a buffer with the top offenders in it,
and thus getting a list of the longest latency introducing sections.
 Or would it be 'better' to instrument with something like kprobes and
have a utility for this functionality ?

 Any further idea of stuff to trace ? or has this already been done
and I am unaware of it ?

 I basicly want a list of the sections in the kernel that disables
preemption for the longest time.

 / regards, Lars Segerlund.
