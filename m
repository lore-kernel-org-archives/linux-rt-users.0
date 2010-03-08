From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 0/1] rt-tests: fix-policy-display-for-cyclictest.patch
Date: Mon, 08 Mar 2010 09:37:49 +0100
Message-ID: <20100308083749.529203420@osadl.org>
Cc: Clark Williams <williams@redhat.com>,
	RT-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:35457 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab0CHIkY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 03:40:24 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Display all policies of cyclictest, if forced to something else
than specified.

Evaluate the priority before it is decremented. 

