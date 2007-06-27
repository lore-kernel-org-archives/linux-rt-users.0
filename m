From: Manfred Gruber <m.gruber@tirol.com>
Subject: Re: poison_obj latency
Date: Wed, 27 Jun 2007 15:24:25 +0200
Message-ID: <200706271524.25557.m.gruber@tirol.com>
References: <200706271251.58092.m.gruber@tirol.com> <20070627123435.GA24977@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 85-126-107-146.static.sdsl-line.inode.at ([85.126.107.146]:3835
	"EHLO mail.contec.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbXF0NY1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Jun 2007 09:24:27 -0400
In-Reply-To: <20070627123435.GA24977@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Am Mittwoch, 27. Juni 2007 14:34 schrieben Sie:
> * Manfred Gruber <m.gruber@tirol.com> wrote:
> > hi !
> >
> > I use a arm4vt ep93xx processor with 2.6.21.5-rt18.
> > When i run cyclictest with -i 10000 and -n -p 90 -b 1000 i see some
> > strange latencies in poison_obj.
>
> disable SLAB_DEBUG. And look into your 'dmesg' output, the -rt kernel
> will warn about any other kernel config options as well that are known
> to cause large latencies:
>
> VFS: Mounted root (ext3 filesystem) readonly.
> ***************************************************************************
>** *                                                                        
>   * *  REMINDER, the following debugging option is turned on in your
> .config:   * *                                                             
>              * *        CONFIG_SLAB                                        
>                * *                                                         
>                  * *  it may increase runtime overhead and latencies.      
>                    * *                                                     
>                      *
> ***************************************************************************
>** Freeing unused kernel memory: 324k freed
>
> 	Ingo

ok, thanks without SLAB_DEBUG there is no poison_obj latency.

-- 
mfg
	Manfred Gruber
