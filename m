From: Lars Segerlund <lars.segerlund@gmail.com>
Subject: x86 question ...
Date: Tue, 11 Sep 2012 00:55:22 +0200
Message-ID: <CAF-VNaqQC94rTrT9E=Dkp0f-NC0YyWXi2rWjsn3XOFMp+feJ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51100 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2IJWzX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Sep 2012 18:55:23 -0400
Received: by eekc1 with SMTP id c1so1557470eek.19
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Sep 2012 15:55:22 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 I read that on arm there was a set of patches for using a single
virtual adress space, ( ie. all processes live in the same mapping so
to speak , but still protected ), which greatly reduced context
switching time on that platform, does anyone know if the same would be
true for x86 ( maily x86_64 ).

 I believe the main gain was in not needing to invalidate the caches
or something like that, it came to mind after seeing a paper on
uClinux with rt versus regular linux and the latency times ?
 I have been googling a bit but I not up to date on cache & memory
architecture on both platforms.

 It's easy to se that uClinux would have an advantage :-D ... no  TLB
and such, only directly mapped memory. But would a single adress space
for all processes have the same effect ?

 Just curious ....

 / regards, Lars Segerlund.
