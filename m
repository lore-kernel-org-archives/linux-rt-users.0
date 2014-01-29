From: "Kim H. Madsen" <kim@undo.dk>
Subject: priority inheritance on kernel semaphore?
Date: Wed, 29 Jan 2014 08:07:36 +0100
Message-ID: <20140129070736.78924D6CCE2A@bmail06.one.com>
Reply-To: kim@undo.dk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from webmail-out1.one.com ([91.198.169.16]:47276 "EHLO
	webmail-out1.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbaA2HHi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 29 Jan 2014 02:07:38 -0500
Received: from bmail06.one.com (bmail06.one.com [91.198.169.71])
	by webmail-out1.one.com (Postfix) with ESMTP id 7C97E3E997
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2014 08:07:36 +0100 (CET)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

According to <https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO> the
preempt-rt patch is "Implementing priority inheritance for in-kernel
spinlocks and semaphores.".

Testing this on 2.6.33.7-rt29 and 3.4.37-rt51 using up()/down() seems to
give another result? PI works fine when using rt_mutex instead in the test. Have I
failed in the testing/configuration or is the documentation out of date?


- Kim