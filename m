From: "Brad Mouring" <bmouring@ni.com>
Subject: [re: PATCH] rtmutex.c: Fix incorrect waiter check
Date: Wed, 14 Jan 2015 15:11:37 -0600
Message-ID: <1421269898-30591-1-git-send-email-brad.mouring@ni.com>
References: <548F7E4C.90805@hp.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, T Makphaibulchoke <tmac@hp.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:52407 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752308AbbANVL5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Jan 2015 16:11:57 -0500
In-Reply-To: <548F7E4C.90805@hp.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Putting this back to the list since I've only received positive feedback for this simple change.
