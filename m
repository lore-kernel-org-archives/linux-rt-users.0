From: Peter Feuerer <peter@piie.net>
Subject: catching interrupts
Date: Tue, 12 Jun 2007 22:17:11 +0200
Message-ID: <1181679431.4904.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:52097 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559AbXFLURT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jun 2007 16:17:19 -0400
Received: from unknown (HELO [192.168.0.4]) (650477@[82.212.56.251])
          (envelope-sender <peter@piie.net>)
          by smtprelay03.ispgateway.de (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 12 Jun 2007 20:17:16 -0000
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

is it possible to catch e.g. the interrupt of the Parallelport (IRQ7 in
my case) in userspace with a RT-Rreempt patched kernel?

--peter
