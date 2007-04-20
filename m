From: Alessio Igor Bogani <abogani@texware.it>
Subject: GPL SYMBOL
Date: Fri, 20 Apr 2007 12:48:00 +0200
Message-ID: <1177066081.11356.5.camel@godzilla>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:53968 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754472AbXDTLGS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Apr 2007 07:06:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by hermes.xcon.it (Postfix) with ESMTP id DD7466080F2
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Apr 2007 12:48:02 +0200 (CEST)
Received: from hermes.xcon.it ([127.0.0.1])
	by localhost (hermes.xcon.it [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id A33Tk076R50g for <linux-rt-users@vger.kernel.org>;
	Fri, 20 Apr 2007 12:48:02 +0200 (CEST)
Received: from [192.168.1.112] (unknown [151.16.232.180])
	(Authenticated sender: aib@texware.it)
	by hermes.xcon.it (Postfix) with ESMTP id 27B456080F0
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Apr 2007 12:48:02 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

Sorry for the stupid question.

What is the reason to declare pagefault_enable() and pagefault_disable()
as only GPL symbol in mm/memory.c (obviously when applied ingo's
realtime patch)? 

There aren't closed source driver that expect to use these?

Thanks in advance!

Ciao,
Alessio
