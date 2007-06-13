From: Bernhard Kuhn <kuhn@l1nuxh4ck3r.de>
Subject: Re: catching interrupts
Date: Wed, 13 Jun 2007 02:04:20 +0200
Message-ID: <466F3484.3000202@l1nuxh4ck3r.de>
References: <1181679431.4904.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cg-p07-fb.rzone.de ([81.169.146.215]:45970 "EHLO
	cg-p07-fb.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbXFMADJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jun 2007 20:03:09 -0400
Received: from mo-p00-ob.rzone.de (mrclete-mo-p00-ob.mail [192.168.63.64])
	by gibbsson-fb-02.store (RZmta 7.2) with ESMTP id 2011a8j5CKqqiu
	for <linux-rt-users@vger.kernel.org>;
	Wed, 13 Jun 2007 02:03:08 +0200 (MEST)
Received: from [192.168.0.1]
	(ppp-82-135-14-221.dynamic.mnet-online.de [82.135.14.221])
	by post.webmailer.de (mrclete mo7) (RZmta 7.2)
	with ESMTP id R0152ej5CLOMCt for <linux-rt-users@vger.kernel.org>;
	Wed, 13 Jun 2007 02:01:53 +0200 (MEST)
In-Reply-To: <1181679431.4904.2.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Peter Feuerer wrote:

> is it possible to catch e.g. the interrupt of the Parallelport (IRQ7 in
> my case) in userspace with a RT-Rreempt patched kernel?

A very simple solution would be to create a small kernel device driver
that implements a blocking read function that always gets woken up
by the parport interrupt service routine, then sending one dummy byte.

But i guess a better variant would be to adopt the IIO framework
for your purpose (http://lkml.org/lkml/2006/8/30/22)

regards

Bernhard
