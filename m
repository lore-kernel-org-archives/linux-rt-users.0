From: "Uli Brueggemann" <uli.brueggemann@gmail.com>
Subject: 2.6.24-rt1 SSttrraannggee keyboard behaviour
Date: Fri, 1 Feb 2008 16:06:23 +0100
Message-ID: <10a58eee0802010706s65929d0dte10a4cde35df317f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:57337 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbYBAPGY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Feb 2008 10:06:24 -0500
Received: by wa-out-1112.google.com with SMTP id v27so736570wah.23
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Feb 2008 07:06:23 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I'm trying to use 2.6.24-rt1 in combination with BruteFIR (audio). So
far everything looks fine except:

After starting BruteFIR (which is doing its job) after a while the
keyboard responds like with double clicks. TTeerrrriibbllee. I cannot
enter a command anymore. The running BruteFIR itself still is running
stable.
 The system without starting BruteFIR keeps stable. BruteFIR itself is
working fine with older kernels. Also with e.g. 2.6.24-rc3-zen3. So I
guess the realtime patch is causing this.
BTW Brutefir is using realtime priorities 1 to 4 and it also uses SCHED_FIFO.

Any idea?

Uli
