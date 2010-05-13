From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: Differnce between kthread and worqueue ?
Date: Thu, 13 May 2010 12:55:56 +0530
Message-ID: <AANLkTik5vq9XHP4eCYw2J4eZVf3pwJZGP_9C4T93otAs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52682 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964Ab0EMHZ6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 May 2010 03:25:58 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

What is the real difference between these ? . I know that workqueue
run on process context and can sleep ..what about kthread ?

Thanks.
Ratheesh
