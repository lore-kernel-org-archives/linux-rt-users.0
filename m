From: "Gregory Haskins" <ghaskins@novell.com>
Subject: [ANNOUNCE] Preempt-test v4 released
Date: Wed, 28 Nov 2007 11:53:03 -0500
Message-ID: <474D569F.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mcclure-nat.wal.novell.com ([130.57.22.22]:31448 "EHLO
	mcclure.wal.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760112AbXK1Q6L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Nov 2007 11:58:11 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


v4 is a minor update over v3 to improve the accuracy of the latency measurement.  v3 used a different startup barrier mechanism which made thread #1 report a falsely large latency.

http://rt.wiki.kernel.org/index.php/Preemption_Test

Regards,
-Greg
