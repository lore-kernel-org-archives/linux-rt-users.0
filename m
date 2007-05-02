From: Alessio Igor Bogani <abogani@texware.it>
Subject: pagefault_enable & pagefault_disable
Date: Wed, 02 May 2007 11:59:14 +0200
Message-ID: <1178099954.5300.13.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hermes.xcon.it ([62.48.35.101]:43549 "EHLO hermes.xcon.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754961AbXEBJ7V (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2007 05:59:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by hermes.xcon.it (Postfix) with ESMTP id E522E6080B9
	for <linux-rt-users@vger.kernel.org>; Wed,  2 May 2007 11:59:18 +0200 (CEST)
Received: from hermes.xcon.it ([127.0.0.1])
	by localhost (hermes.xcon.it [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EQJJ2VxcVBnA for <linux-rt-users@vger.kernel.org>;
	Wed,  2 May 2007 11:59:18 +0200 (CEST)
Received: from [192.168.100.121] (adsl203-157-083.mclink.it [213.203.157.83])
	(Authenticated sender: aib@texware.it)
	by hermes.xcon.it (Postfix) with ESMTP id 28E576080B8
	for <linux-rt-users@vger.kernel.org>; Wed,  2 May 2007 11:59:18 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

What is the reason for declare pagefault_enable and pagefault_disable
as only GPL symbols in mm/memory.c (obviously with Ingo's
realtime patch applied)? 

I violate license if i change those two EXPORT_SYMBOL_GPL in EXPORT_SYMBOL?

Thanks in advance!

Ciao,
Alessio
