From: Pieter Palmers <pieterp@joow.be>
Subject: 2.6.20-rc7 (today's git) + -rt3 compilation problem
Date: Fri, 02 Feb 2007 10:28:24 +0100
Message-ID: <45C30438.5070208@joow.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from oola.is.scarlet.be ([193.74.71.23]:54113 "EHLO
	oola.is.scarlet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbXBBJm3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Feb 2007 04:42:29 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The following occurred when compiling today's git with the 
patch-2.6.20-rc7-rt3 patch applied:

arch/i386/mm/built-in.o: In function `flush_cr3_cache':
arch/i386/mm/pgtable.c:303: undefined reference to `paravirt_enabled'
arch/i386/mm/pgtable.c:306: undefined reference to `hypercall'
make: *** [.tmp_vmlinux1] Error 1

Adding
#include <linux/paravirt.h>
to pgtable.c fixed the compilation issue, but is that the correct way to go?

Greets,

Pieter Palmers
