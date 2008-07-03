From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Get RT-linux working on a Routerboard 532
Date: Thu, 03 Jul 2008 07:55:38 -0700
Message-ID: <1215096938.3400.25.camel@localhost.localdomain>
References: <20080702165245.ezannbafk884owos@www.enseirb.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Jean Collas <jean.collas@enseirb.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:6216 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbYGCOzk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Jul 2008 10:55:40 -0400
In-Reply-To: <20080702165245.ezannbafk884owos@www.enseirb.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 2008-07-02 at 16:52 +0200, Jean Collas wrote:
> Hi everybody,
> As I had troubles with majordomo, I am not sure my previous mail had  
> been sent, otherwise sorry for the inconvenience.
> 
> I was wondering if someone has already tried to apply the rt-linux  
> patch on a RB532.
> 
> I work with OpenWRT to add the RB532 on MIPS machines. I am trying add  
> this rt-patch, but I have an issue with a non-existing extern function  
> introduced by the rt-patch (__bad_rwlock_type).
> Can anybody help ?

That function isn't suppose to exist. It's there to cause the build to
stop when a locking API is used with an unknown lock type. So in your
case you must be trying to do rwlock operations on something that isn't
an rwlock, or a raw_rwlock .. 

Daniel

