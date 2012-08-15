From: Tim Sander <tstone@iss.tu-darmstadt.de>
Subject: Re: RT patch for 2.6.16.28 kernel
Date: Wed, 15 Aug 2012 08:42:43 +0200
Message-ID: <201208150842.44943.tstone@iss.tu-darmstadt.de>
References: <CCBC25FF95083B478959E6FCEF2E662208AA43CE@TAIMBX1.dmntai.intra>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx141.hrz.tu-darmstadt.de ([130.83.156.236]:46579 "EHLO
	lnx141.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751519Ab2HOGtj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Aug 2012 02:49:39 -0400
Received: from lnx500.hrz.tu-darmstadt.de (lnx500.hrz.tu-darmstadt.de [130.83.156.225])
	by lnx141.hrz.tu-darmstadt.de (8.14.4/8.13.8) with ESMTP id q7F6hTRs004203
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Aug 2012 08:43:29 +0200
	(envelope-from tstone@iss.tu-darmstadt.de)
Received: from iss1.vlsi.informatik.tu-darmstadt.de (iss1.vlsi.informatik.tu-darmstadt.de [130.83.164.1])
	by lnx500.hrz.tu-darmstadt.de (8.14.4/8.14.4/HRZ/PMX) with ESMTP id q7F6gjSa016970
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Aug 2012 08:42:45 +0200
	(envelope-from tstone@iss.tu-darmstadt.de)
Received: from localhost (localhost [127.0.0.1])
	by iss1.vlsi.informatik.tu-darmstadt.de (Postfix) with ESMTP id 4B159FC26
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Aug 2012 08:42:45 +0200 (CEST)
Received: from iss1.vlsi.informatik.tu-darmstadt.de ([127.0.0.1])
	by localhost (iss1.vlsi.informatik.tu-darmstadt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KDqvSsva+EYW for <linux-rt-users@vger.kernel.org>;
	Wed, 15 Aug 2012 08:42:45 +0200 (CEST)
Received: from lvxen-nx.vlsi (iss5.vlsi.informatik.tu-darmstadt.de [130.83.164.5])
	by iss1.vlsi.informatik.tu-darmstadt.de (Postfix) with ESMTP id 3C149FBCD
	for <linux-rt-users@vger.kernel.org>; Wed, 15 Aug 2012 08:42:45 +0200 (CEST)
In-Reply-To: <CCBC25FF95083B478959E6FCEF2E662208AA43CE@TAIMBX1.dmntai.intra>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi bbilen or however your name is...
> I'd like to run RT Linux on a Viper Development board (PXA255 ,
> http://www.eurotech-inc.com/single-board-computer-pxa255-pc104-viper-lite.a
> sp) . Kit came with a custom Linux (2.6.16.28). I checked RT patches here:
> http://www.kernel.org/pub/linux/kernel/projects/rt/ but there are not any a
> 2.6.16.* versions.  As this kernel is custom and tested well with this
> board I am hesitant to upgrade the kernel but can't find the relevant
> patch.  In pages like this:
> http://lkml.indiana.edu/hypermail/linux/kernel/0606.1/1179.html I saw a
> 2.6.16 version is mentioned. Is there a 2.6.16 rt patch somewhere?
There are only preempt rt versions for selected kernel versions as porting the 
patches to other versions is quite some work. So you have to live with what is 
there. As 2.6.16 is pretty dated i would ask your vendor to give you a more 
recent kernel. I would recomend you to look for close mainline support for 
your next project...

Tim
