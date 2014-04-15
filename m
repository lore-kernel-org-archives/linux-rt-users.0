From: John Kacur <jkacur@redhat.com>
Subject: RFC: SIGUSR1 to stderr
Date: Tue, 15 Apr 2014 16:28:11 +0200
Message-ID: <CAONaPpEyH5r6iYRBS69T6A+Zm5rmpx=2-_CSAw9JXbQDFFoAHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:39581 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaDOO2M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Apr 2014 10:28:12 -0400
Received: by mail-we0-f182.google.com with SMTP id p61so9445113wes.41
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Apr 2014 07:28:11 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We usually do testing by running cyclictest laucned via rteval. It
would be nice to get status updates from cyclictest in the middle of
long runs (sometimes days long). cyclictest already has the capability
to do this via SIGUSR1.

It would be useful for rteval parsing of SIGUSR1 output if this were
directed to stderr. I could make this the default, but don't want to
do this if it would interfere with the way anyone else is doing
testing. If this would cause a problem for you, I'll just make it an
option.

So, please let me know if this change would cause problems for you.

Thanks

John
