Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39275C04A68
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jul 2022 20:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiG0Uco (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Jul 2022 16:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiG0Ucn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Jul 2022 16:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B70A52E75
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Jul 2022 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658953961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WhFdwoNXGy1irwK3RFusQd0VxboMIKWNlgcl40GomJI=;
        b=aMyjMqcXa8keOmb3b+H+9ym4qsZ6P7M/wC4dvat3bU0x8GbChVsnIaj0KtTFf/KswniKcL
        ZIi+BX+sJmK0gsAtvX+/yMZklcIoKIULjoZI/9HF4pUi0ktvW+VcuA45yC8Kyq+Gitu2Vd
        mMsq8OxhgyAiNHnzNeXuyL07m+38l7k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-jqOAjiKiObae-k-iNiF3ew-1; Wed, 27 Jul 2022 16:32:39 -0400
X-MC-Unique: jqOAjiKiObae-k-iNiF3ew-1
Received: by mail-qt1-f197.google.com with SMTP id a10-20020ac84d8a000000b0031ee6389b7eso9732216qtw.6
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Jul 2022 13:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WhFdwoNXGy1irwK3RFusQd0VxboMIKWNlgcl40GomJI=;
        b=H2yw+KX90fE0PUae4KjkL7TtwMA72PcIAkfXuv5STnydcOysJ5YQ2bpgH1U+GVR1zY
         sEw+XWRSKIFIWaiZtekSHnUpoYOhzpZy1MU0bhDHxdvjmh43b9gzKqjz11IT/GtTHj4l
         VSX4vn6RB5tZdAa4xfeBKkd/3XVFCTWTcZkLWBBdOG+OvDyZvs8u3tZlBYuwXbl2yUlz
         6G/oLBjapVGN7iNIv/iwlhemxfNEDLq2Eb31qplbgnpd85Lcv+EnxPJ3YqPj24mYoax9
         6WW1RCCjmXW3KidRJSlxixn9g4K84J34YVy6uJu/4rnh4r0219j+f1WvVpCzAKUCh87N
         OCPg==
X-Gm-Message-State: AJIora85ndoyUZtAUC20IR/nIEapOEr/AjM9xIfM70vQ/S2P1vjet3nF
        doEyah0/WSowCe9LirKJKwvop3VZyKO0KAkiLebh4Yz4bxVfXZMFFDUE0hO7l4JQmNKQH13CRZs
        T8iyFKxHslpJbqFhdciSM2QLnuJI=
X-Received: by 2002:ac8:5dcd:0:b0:31f:4cbc:d9e4 with SMTP id e13-20020ac85dcd000000b0031f4cbcd9e4mr2834302qtx.615.1658953958501;
        Wed, 27 Jul 2022 13:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOQNZSbQUk0mwVpDZKE9VqmtIRXRMH/KweXI4hck85ac+k+6OFUM9ckxJivL5mEscsOnvpeg==
X-Received: by 2002:ac8:5dcd:0:b0:31f:4cbc:d9e4 with SMTP id e13-20020ac85dcd000000b0031f4cbcd9e4mr2834275qtx.615.1658953958090;
        Wed, 27 Jul 2022 13:32:38 -0700 (PDT)
Received: from lleshchi.bos.csb (cpe-24-198-132-134.maine.res.rr.com. [24.198.132.134])
        by smtp.gmail.com with ESMTPSA id l25-20020a37f919000000b006b61b2cb1d2sm2627953qkj.46.2022.07.27.13.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 13:32:37 -0700 (PDT)
Date:   Wed, 27 Jul 2022 16:32:34 -0400
From:   Leah Leshchinsky <lleshchi@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Manasi Godse <magodse@redhat.com>
Subject: Re: [PATCH 1/6] rteval: Create common  functions in CpuList and
 SysTopology
Message-ID: <YuGg4u05uB9Ajc5d@lleshchi.bos.csb>
References: <20220726133535.10824-1-jkacur@redhat.com>
 <20220726133535.10824-2-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726133535.10824-2-jkacur@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jul 26, 2022 at 09:35:30AM -0400, John Kacur wrote:
> The purpose is to remove functions out of misc and use the ones in the
> file systopolgy.py
> 
> - Add function collapse_cpulist(cpulist)  outside of the CpuList
>   class
> - Make methods longest_sequence and expand_cpulist accesible outside of
>   their class
> - Add function online_cpus(self) to class SysTopology
> - Add function online_cpus_str(self) to class SysTopology
> - Add function invert_cpulist(self, cpulist) to class SysTopology
> - Convert strings to f-strings for better readability
> - Add a few missing docstrings to methods / functions, module etc
> - Add a few more tests to the unit test
> 
> TODO: CpuList is suited for use by SysTopology, but is not ideal for a
> generic CpuList. A more generally usable CpuList should be created
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  rteval/systopology.py | 90 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 74 insertions(+), 16 deletions(-)
> 
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index e852f86e450f..ce8d02cf7318 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -23,11 +23,32 @@
>  #   including keys needed to generate an equivalently functional executable
>  #   are deemed to be part of the source code.
>  #
> +""" Module for querying cpu cores and nodes """
>  
>  import os
>  import os.path
>  import glob
>  
> +# Utility version of collapse_cpulist that doesn't require a CpuList object
> +def collapse_cpulist(cpulist):
> +    """ Collapse a list of cpu numbers into a string range
> +        of cpus (e.g. 0-5, 7, 9) """
> +    if len(cpulist) == 0:
> +        return ""
> +    idx = CpuList.longest_sequence(cpulist)
> +    if idx == 0:
> +        seq = str(cpulist[0])
> +    else:
> +        if idx == 1:
> +            seq = f"{cpulist[0]},{cpulist[idx]}"
> +        else:
> +            seq = f"{cpulist[0]}-{cpulist[idx]}"
> +
> +    rest = collapse_cpulist(cpulist[idx+1:])
> +    if rest == "":
> +        return seq
> +    return ",".join((seq, rest))
> +
>  def sysread(path, obj):
>      """ Helper function for reading system files """
>      with open(os.path.join(path, obj), "r") as fp:
> @@ -46,7 +67,7 @@ class CpuList:
>          if isinstance(cpulist, list):
>              self.cpulist = cpulist
>          elif isinstance(cpulist, str):
> -            self.cpulist = self.__expand_cpulist(cpulist)
> +            self.cpulist = self.expand_cpulist(cpulist)
>          self.cpulist = self.online_cpulist(self.cpulist)
>          self.cpulist.sort()
>  
> @@ -67,7 +88,7 @@ class CpuList:
>          return False
>  
>      @staticmethod
> -    def __longest_sequence(cpulist):
> +    def longest_sequence(cpulist):
>          """ return index of last element of a sequence that steps by one """
>          lim = len(cpulist)
>          for idx, _ in enumerate(cpulist):
> @@ -83,14 +104,14 @@ class CpuList:
>          """
>          if len(cpulist) == 0:
>              return ""
> -        idx = self.__longest_sequence(cpulist)
> +        idx = self.longest_sequence(cpulist)
>          if idx == 0:
>              seq = str(cpulist[0])
>          else:
>              if idx == 1:
> -                seq = "%d,%d" % (cpulist[0], cpulist[idx])
> +                seq = f"{cpulist[0]},{cpulist[idx]}"
>              else:
> -                seq = "%d-%d" % (cpulist[0], cpulist[idx])
> +                seq = f"{cpulist[0]}-{cpulist[idx]}"
>  
>          rest = self.__collapse_cpulist(cpulist[idx+1:])
>          if rest == "":
> @@ -98,7 +119,14 @@ class CpuList:
>          return ",".join((seq, rest))
>  
>      @staticmethod
> -    def __expand_cpulist(cpulist):
> +    def compress_cpulist(cpulist):
> +        """ return a string representation of cpulist """
> +        if isinstance(cpulist[0], int):
> +            return ",".join(str(e) for e in cpulist)
> +        return ",".join(cpulist)
> +
> +    @staticmethod
> +    def expand_cpulist(cpulist):
>          """ expand a range string into an array of cpu numbers
>          don't error check against online cpus
>          """
> @@ -124,8 +152,8 @@ class CpuList:
>      def is_online(self, n):
>          """ check whether cpu n is online """
>          if n not in self.cpulist:
> -            raise RuntimeError("invalid cpu number %d" % n)
> -        path = os.path.join(CpuList.cpupath, 'cpu%d' % n)
> +            raise RuntimeError(f"invalid cpu number {n}")
> +        path = os.path.join(CpuList.cpupath, f'cpu{n}')
>  
>          # Some hardware doesn't allow cpu0 to be turned off
>          if not os.path.exists(path + '/online') and n == 0:
> @@ -240,8 +268,8 @@ class SysTopology:
>          return len(list(self.nodes.keys()))
>  
>      def __str__(self):
> -        s = "%d node system" % len(list(self.nodes.keys()))
> -        s += " (%d cores per node)" % (len(self.nodes[list(self.nodes.keys())[0]]))
> +        s = f"{len(list(self.nodes.keys()))} node system "
> +        s += f"({(len(self.nodes[list(self.nodes.keys())[0]]))} cores per node)"
>          return s
>  
>      def __contains__(self, node):
> @@ -268,6 +296,7 @@ class SysTopology:
>          return n
>  
>      def getinfo(self):
> +        """ Initialize class Systopology """
>          nodes = glob.glob(os.path.join(SysTopology.nodepath, 'node[0-9]*'))
>          if nodes:
>              nodes.sort()
> @@ -278,27 +307,56 @@ class SysTopology:
>              self.nodes[0] = SimNumaNode()
>  
>      def getnodes(self):
> +        """ return a list of nodes """
>          return list(self.nodes.keys())
>  
>      def getcpus(self, node):
> +        """ return a dictionary of cpus keyed with the node """
>          return self.nodes[node].getcpulist()
>  
> +    def online_cpus(self):
> +        """ return a list of integers of all online cpus """
> +        cpulist = []
> +        for n in self.nodes:
> +            cpulist += self.getcpus(n)
> +        cpulist.sort()
> +        return cpulist
> +
> +    def online_cpus_str(self):
> +        """ return a list of strings of numbers of all online cpus """
> +        cpulist = [str(cpu) for cpu in self.online_cpus()]
> +        return cpulist
> +
> +    def invert_cpulist(self, cpulist):
> +        """ return a list of online cpus not in cpulist """
> +        return [c for c in self.online_cpus_str() if c not in cpulist]
>  
>  if __name__ == "__main__":
>  
>      def unit_test():
> +        """ unit test, run python rteval/systopology.py """
>          s = SysTopology()
>          print(s)
> -        print("number of nodes: %d" % len(s))
> +        print(f"number of nodes: {len(s)}")
>          for n in s:
> -            print("node[%d]: %s" % (n.nodeid, n))
> -        print("system has numa node 0: %s" % (0 in s))
> -        print("system has numa node 2: %s" % (2 in s))
> -        print("system has numa node 24: %s" % (24 in s))
> +            print(f"node[{n.nodeid}]: {n}")
> +        print(f"system has numa node 0: {0 in s}")
> +        print(f"system has numa node 2: {2 in s}")
> +        print(f"system has numa node 24: {24 in s}")
>  
>          cpus = {}
> +        print(f"nodes = {s.getnodes()}")
>          for node in s.getnodes():
>              cpus[node] = s.getcpus(int(node))
> -        print(f'cpus = {cpus}')
> +            print(f'cpus = {cpus}')
> +
> +        onlcpus = s.online_cpus()
> +        print(f'onlcpus = {onlcpus}')
> +        onlcpus = collapse_cpulist(onlcpus)
> +        print(f'onlcpus = {onlcpus}')
> +
> +        onlcpus_str = s.online_cpus_str()
> +        print(f'onlcpus_str = {onlcpus_str}')
>  
> +        print(f"invert of [ 2, 4, 5 ] = {s.invert_cpulist([2, 3, 4])}")
>      unit_test()
> -- 
> 2.37.1
> 

collapse_cpulist():

- Ordered numerical lists work properly [1,2,3,4,5,10,11,12,15,18,19,20] => '1-5,10-12,15,18-20'
- Empty list works as expected [] => ''
- Non-numerical elements result in ValueError ["a", 2, 3] => ValueError
- Mixture of numerical interger and string elements works properly ["0",2,3,4] => '0,2-4'

- Unordered list does not produce range. [0,10,11,12,2,5,4,3] => '0,10-12,2,5,4,3'
  Consider sorting the list before operating on it.
- Providing string to function that expects a list results in strange behavior '123' => '1-3'
  Perhaps check for whether a list was provided prior to operating on input

CpuList.compress_cpulist():

- Does not accept empty list [] => IndexError.
  Consider handling this case.
- Compress_cpulist is a bit misleading for a function that returns a string representation, and could be confused with collapse_cpulist.
  Consider renaming to something the indicates str output.

SysTopology.online_cpus():

- Tested by intializing SysTopology object, calling online_cpus showed [0,1,2,3,4,5,6,7],
then disabled cpu 4 and tested again by calling online_cpus(), which still showed cpu 4 as active.
Reinitializing the class and calling online_cpus() worked properly and showed [1,2,3,5,6,7] where cpu 4 was disabled.
Consider adding a comment to indicate that this function displays the state of the system at class initialization.
In the future, a function may be added to display the state of the system at function call time.

>>> top = st.SysTopology()
>>> top.online_cpus()
[0, 1, 2, 3, 4, 5, 6, 7]

$ su -c 'echo 0 > /sys/devices/system/cpu/cpu4/online '

>>> top.online_cpus()
[0, 1, 2, 3, 4, 5, 6, 7]
>>> top = st.SysTopology()
>>> top.online_cpus()
[0, 1, 2, 3, 5, 6, 7]

