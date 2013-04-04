From: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
Subject: Re: malloc/free and priority inheritance?
Date: Thu, 4 Apr 2013 19:07:01 +0530
Message-ID: <CAAHN_R1zLdHqpC4JGxjJtADRWGA0hC=G2C3=0Z21KTKk5HJNtg@mail.gmail.com>
References: <515B647C.3080505@meduna.org>
	<515D7943.5000401@meduna.org>
	<515D808C.8090808@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: libc-help <libc-help@sourceware.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:61147 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760776Ab3DDNhF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Apr 2013 09:37:05 -0400
Received: by mail-we0-f169.google.com with SMTP id x43so2078824wey.14
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Apr 2013 06:37:01 -0700 (PDT)
In-Reply-To: <515D808C.8090808@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 4 April 2013 19:00, Stanislav Meduna <stano@meduna.org> wrote:

> hm well.. the assembler version of e.g. __pthread_cond_broadcast
> in 2.17 for x86 seems to be using the PI. No luck with ARM (2.16
> in ports) though.

The generic C code was updated to use PI in current master (I don't
remember if the arm support bits were added, but they must have been
by now), so you could cherry-pick and backport those bits for your
distro if you want.

Siddhesh
--
http://siddhesh.in
