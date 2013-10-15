From: =?ISO-8859-1?Q?Matthias_D=FCbon?= <matthias.duebon@ing-duebon.de>
Subject: =?windows-1252?Q?error=3A_implicit_declaration_of_function_=91do=5Fsoftir?=
	=?windows-1252?Q?q=92?=
Date: Tue, 15 Oct 2013 18:14:01 +0200
Message-ID: <CAMj341OaVOXvcjvw75CoKSF1=YaBcVHa026LQ8VY2KXyUtOBaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:57038 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437Ab3JOQOD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Oct 2013 12:14:03 -0400
Received: by mail-qe0-f49.google.com with SMTP id a11so1440302qen.8
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Oct 2013 09:14:01 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello everyone,
I am just experimenting with the RT preempt patch
patch-3.10.15-rt11.patch.bz2 and a 3.10.16 kernel for x86 architecture
with a "standard" .config file.
I configured CONFIG_PREEMPT_RT_FULL=3Dy

when building the kernel I got the following error:

"kernel/softirq.c: In function =91invoke_softirq=92:
kernel/softirq.c:710:3: error: implicit declaration of function
=91do_softirq=92 [-Werror=3Dimplicit-function-declaration]"

Is this related to my kernel configuration?

kind regards,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
