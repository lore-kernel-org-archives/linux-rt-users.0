From: "Gerhard Olsson" <gerhard.nospam@gmail.com>
Subject: Re: 2.6.20-rc7 (today's git) + -rt3 compilation problem
Date: Fri, 2 Feb 2007 12:52:24 +0100
Message-ID: <d4209ca0702020352t6d7db425vf63e44a2b7cbe3c6@mail.gmail.com>
References: <45C30438.5070208@joow.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Pieter Palmers" <pieterp@joow.be>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:16715 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422775AbXBBLw0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Feb 2007 06:52:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so737495uga
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Feb 2007 03:52:24 -0800 (PST)
In-Reply-To: <45C30438.5070208@joow.be>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Another workaround is to modify the config:
CONFIG_PARAVIRT=y

(There was similar problems with SMP a while ago, a hint to enable
functionality related to compile errors should possibly be mentioned
in the wiki?

/Gerhard

On 2/2/07, Pieter Palmers <pieterp@joow.be> wrote:
> The following occurred when compiling today's git with the
> patch-2.6.20-rc7-rt3 patch applied:
>
> arch/i386/mm/built-in.o: In function `flush_cr3_cache':
> arch/i386/mm/pgtable.c:303: undefined reference to `paravirt_enabled'
> arch/i386/mm/pgtable.c:306: undefined reference to `hypercall'
> make: *** [.tmp_vmlinux1] Error 1
>
> Adding
> #include <linux/paravirt.h>
> to pgtable.c fixed the compilation issue, but is that the correct way to go?
>
> Greets,
>
> Pieter Palmers
