From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH -rt] CONFIG_PARAVIRT and CONFIG_MCOUNT don't play well
 together
Date: Fri, 22 Jun 2007 09:19:41 -0700
Message-ID: <467BF69D.4030806@goop.org>
References: <20070622080634.GP3723@sequoia.sous-sol.org> <20070622083330.GB19382@elte.hu> <20070622152915.GQ3723@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:41131 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757416AbXFVQUV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jun 2007 12:20:21 -0400
In-Reply-To: <20070622152915.GQ3723@sequoia.sous-sol.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Chris Wright wrote:
> Yes, I agree, it's actually documenting the subtlety of the calling
> convention, not just noise in the source.  The upstream patch is
> different, I'll sort one out.

I wonder if we should use something like "regparm" rather than 
"fastcall"?  The latter makes it sound like its just a performance issue.

    J
