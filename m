From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: [PATCH] Revert "simplify equal priority logic for cyclictest"
Date: Mon, 08 Mar 2010 09:01:56 +0100
Message-ID: <4B94AEF4.8050204@osadl.org>
References: <1268011104-22451-1-git-send-email-jkacur@redhat.com> <1268011104-22451-2-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:35180 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475Ab0CHIKY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Mar 2010 03:10:24 -0500
In-Reply-To: <1268011104-22451-2-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/08/2010 02:18 AM, John Kacur wrote:
> Unfortunately this commit introduces a bug because the priority is not
> retested, and this can result in reported priorities below 0.
> [..]
> I think it can be argued that the original code is also clearer, although
> that is somewhat subjective. With the original code I don't need to track
> down exactly what "sameprio" means, and it is clear what is being tested.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
Acked-by: Carsten Emde <C.Emde@osadl.org>
