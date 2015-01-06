From: "Vegara Dorian" <vegara.e1300478@etud.univ-ubs.fr>
Subject: How can I disable VHCI support ?
Date: Tue, 6 Jan 2015 17:27:14 +0100 (CET)
Message-ID: <60762.90.32.177.45.1420561634.squirrel@webmail.etud.univ-ubs.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vohkoohe.univ-ubs.fr ([193.52.48.68]:60790 "EHLO
	vohkoohe.univ-ubs.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbbAFQpS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Jan 2015 11:45:18 -0500
Received: from storck.univ-ubs.fr (storck.univ-ubs.fr [193.52.32.76])
	by vohkoohe.univ-ubs.fr (8.14.4/8.14.4) with ESMTP id t06GREB9027317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Tue, 6 Jan 2015 17:27:15 +0100
Received: from webmail.etud.univ-ubs.fr (maroro-ng.univ-ubs.fr [193.52.32.91])
	by storck.univ-ubs.fr (8.14.3/8.14.3) with ESMTP id t06GRETh045485
	for <linux-rt-users@vger.kernel.org>; Tue, 6 Jan 2015 17:27:14 +0100 (CET)
	(envelope-from vegara.e1300478@etud.univ-ubs.fr)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I'm trying to patch my Linux with RT Linux 3.14.25. The installation has
been successfully done, but problems appeared when I typed this command :

" make modules_install ".

The error message is : Module 'hci_vhci' has devname (vhci) but lacks
major and minor information. Ignoring.

How can I fix this bug ? I don't want Bluetooth. So I think I can disable
VHCI.


Thanks a lot,
Best regards

Dorian VEGARA

