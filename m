From: Gilles Carry <Gilles.Carry@bull.net>
Subject: Re: [RT PATCH v3 0/2] Fix for "[BUG][PPC64] BUG in 2.6.26.5-rt9 causing
 Hang"
Date: Tue, 07 Oct 2008 08:04:35 +0200
Message-ID: <48EAFBF3.6040607@bull.net>
References: <20080925123235.GA27916@linux.vnet.ibm.com> <20081006151228.8452.69938.stgit@dev.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chirag Jog <chirag@linux.vnet.ibm.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, dvhltc@us.ibm.com, dino@in.ibm.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:40398 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbYJGGII (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Oct 2008 02:08:08 -0400
In-Reply-To: <20081006151228.8452.69938.stgit@dev.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Gregory Haskins wrote:
> Hi Steve,
>   Chirag reported (via IRC) that v2 fixed his issue.  V3 is identical to v2
>   except I cleaned up the patch description and fixed a comment typo.  This
>   applies to 26.5-rt9.  Please consider it an urgent fix for -rt10.
> 

Hi,

After 24 hours of testing on PPC64, I confirm that this patch fixes the issue.

Gilles.
