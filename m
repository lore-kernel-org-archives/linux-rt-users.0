Return-Path: <SRS0=dFCZ=TN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE415C04AA7
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 May 2019 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72CC208C2
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 May 2019 22:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEMWGW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 May 2019 18:06:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfEMWGU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 May 2019 18:06:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 924843087945
        for <linux-rt-users@vger.kernel.org>; Mon, 13 May 2019 22:06:20 +0000 (UTC)
Received: from torg (ovpn-122-60.rdu2.redhat.com [10.10.122.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2725C60856;
        Mon, 13 May 2019 22:06:20 +0000 (UTC)
Date:   Mon, 13 May 2019 17:06:18 -0500
From:   Clark Williams <williams@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rt-tests: hwlatdetect.py: Code clean-up
Message-ID: <20190513170618.7dfd59ba@torg>
In-Reply-To: <20190510140144.6817-1-jkacur@redhat.com>
References: <20190510140144.6817-1-jkacur@redhat.com>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 13 May 2019 22:06:20 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 10 May 2019 16:01:44 +0200
John Kacur <jkacur@redhat.com> wrote:

> - Remove obsolete from __future__
> - Fix spacing around calls to print, open and brackets
> - Fix spacing around assignments
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/hwlatdetect/hwlatdetect.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 368079a158b1..b72bdc3aa930 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -8,7 +8,7 @@
>  # modify it under the terms of the GNU General Public License Version 2
>  # as published by the Free Software Foundation.
>  
> -from __future__ import print_function
> +
>  
>  import sys
>  import os
> @@ -84,7 +84,7 @@ class DebugFS(object):
>              try:
>                  val = f.readline()
>              except OSError as e:
> -                print ("errno: %s" % e)
> +                print("errno: %s" % e)
>                  if e.errno == errno.EAGAIN:
>                      val = None
>                  else:
> @@ -159,7 +159,7 @@ class Kmod(object):
>              return
>  
>          # now look for already loaded module
> -        for l in open ('/proc/modules'):
> +        for l in open('/proc/modules'):
>              field = l.split()
>              if self.name in field[0]:
>                  self.preloaded = True
> @@ -210,7 +210,7 @@ class Detector(object):
>          if self.have_msr:
>              p = subprocess.Popen(['/usr/sbin/rdmsr', '-a', '-d', '0x34'], stdout=subprocess.PIPE)
>              p.wait()
> -            counts = [ int(x.strip()) for x in p.stdout.readlines()]
> +            counts = [int(x.strip()) for x in p.stdout.readlines()]
>          return counts
>  
>      # methods for preventing/enabling c-state transitions
> @@ -295,11 +295,11 @@ class Tracer(Detector):
>  
>      class Sample(object):
>          'private class for tracer sample data'
> -        __slots__= 'timestamp', 'inner', 'outer',
> +        __slots__ = 'timestamp', 'inner', 'outer',
>          def __init__(self, line):
>              fields = line.split()
>              i,o = fields[6].split('/')
> -            ts=fields[7][3:]
> +            ts = fields[7][3:]
>              self.timestamp = str(ts)
>              self.inner = int(i)
>              self.outer = int(o)
> @@ -332,14 +332,14 @@ class Tracer(Detector):
>          self.set('current_tracer', 'hwlat')
>  
>      def set(self, field, val):
> -        path=self.translate(field)
> +        path = self.translate(field)
>          self.debugfs.putval(path, str(val))
>  
>      def get(self, field):
>          if field == "count":
>              return len(self.samples)
>          elif field == "max":
> -            max=0
> +            max = 0
>              for values in self.samples:
>                  s = int(values.largest())
>                  if s > max:
> @@ -435,7 +435,7 @@ class Hwlat(Detector):
>  
>      def display(self):
>          for s in self.samples:
> -            print (s)
> +            print(s)
>  
>      def save(self, output=None):
>          if output:
> -- 
> 2.20.1
> 

Acked-by: Clark Williams <williams@redhat.com>

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
