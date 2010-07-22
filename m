From: Ng Oon-Ee <ngoonee@gmail.com>
Subject: Re: RT support for LTS kernel 2.6.32 ?
Date: Fri, 23 Jul 2010 06:35:30 +0800
Message-ID: <1279838130.19144.4.camel@localhost.localdomain>
References: <AANLkTin0pSTAkyytSokSQLXainZJBVdELOVxYn6OkViw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-9"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Andres Cimmarusti <acimmarusti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62568 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849Ab0GVWfg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Jul 2010 18:35:36 -0400
Received: by pxi14 with SMTP id 14so3367856pxi.19
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Jul 2010 15:35:35 -0700 (PDT)
In-Reply-To: <AANLkTin0pSTAkyytSokSQLXainZJBVdELOVxYn6OkViw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2010-07-22 at 15:51 -0400, Andres Cimmarusti wrote:
> Hi,
> 
> I saw in the kernel archives that the only recent kernels supported by
> the patch are 2.6.33.x. I was wondering if there will be any support
> for the 2.6.32.x kernels which will be long term supported and
> prominent distros like Ubuntu LTS 10.04 and Debian Squeeze 6.0 are
> based on them.
> 
> Thanks
> 
> Andres

I think the decision was taken to only support odd-numbered kernels. For
example the current 2.6.34 will not have a release either.

