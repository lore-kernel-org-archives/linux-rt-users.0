From: GSE <guillaume.sempe@gmail.com>
Subject: ARM PXA255 build error and hundreds warnings
Date: Sun, 6 Jul 2008 11:01:04 +0200
Message-ID: <88fcacda0807060201q6b86992cgea5624c8b53859f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:50248 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbYGFJBF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 6 Jul 2008 05:01:05 -0400
Received: by an-out-0708.google.com with SMTP id d40so344342and.103
        for <linux-rt-users@vger.kernel.org>; Sun, 06 Jul 2008 02:01:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I tried to build RT patch over kernel 2.6.25.
The patch step goes all right (patch patch-2.6.25.8-rt7.bz2)
When I make the kernel there is an error in asm-arm/arch-pxa/timex.h :
OSCR is undefined because the include of pxa registers definition is
conditioned by "defined CONFIG_PXA27X"
and I build for PXA255.
So I add inclusion to the PXA255 compilation in this file.
After this modification the kernel make generate hundreds of warning
like this paste below :

"include/asm-generic/cmpxchg.h:19:1: warning: this is the location of
the previous definition"

Are those warnings normals ?

gsempe.
