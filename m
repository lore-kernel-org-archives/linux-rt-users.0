Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUX+KJXc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17807D0
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702412579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wNsRlllUNc7ducrs+L5EngCRTyE0Z+clOF/7dDm1/r0=;
	b=DUX+KJXc72eCabOcS/kRwYXdonhaozf84oCEtTzsLf1vA4me6n/fEf4/FYL7P025sAt/nX
	uLKVrHwlHuJg5bJv1UK1930141rbjrQo7UCI1zR7pc6M5ypM/zLbYos57jveHYQHDUrU+W
	S7f9TMyuX/p8lSaYbuMoA4aWQnwc3Zk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-rlNzWFheO1uESxvHS1yzoQ-1; Tue, 12 Dec 2023 15:22:57 -0500
X-MC-Unique: rlNzWFheO1uESxvHS1yzoQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67aec8cce57so66580866d6.2
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Dec 2023 12:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412576; x=1703017376;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNsRlllUNc7ducrs+L5EngCRTyE0Z+clOF/7dDm1/r0=;
        b=LTchE15rNrXaE/IHLb4grNbd9NatlExfOzBTMrTE7P7ElR6W4OAn4+FVKpzudUk0YZ
         mICtNlX3rEhNI9t0w1NVMsxlR3lFeHOFHhabRHq269rvFjIXyPWoPFhay6JroXhA7cNh
         tFOQFMx/3Y032M/5aANmV2K0k8WUZ78Px6GIbHcDFGaCwEFWjq2jcwcgKVfT9dbThnFN
         whb1A+dTmrsMAcVZUP7TlvFty5oxC2CLU+Zjjsw1EDfxcy0m1ysduDYhwIkR4TGgvf5M
         YMz+4TdYGBms/SpI4YGs+XI6ncSXLtb2hRdttBd1vZFNzmZoHvvACo19Jb+PxGRcjfG7
         Q+aQ==
X-Gm-Message-State: AOJu0Yzbb9HzbtdokLZGjKIM8zLoU/yMW7Nr+B/mDWb8D3Jetmj9iFKR
	v9ZjgCJ7Oz+6y3kh4/oGMEwX4D5r5eDSKqRTG4bXfxSYr+Sf5SNp5UG1EKgtucDAoKMbSl5qGtK
	/AM2/loITcBAA5HUO8jgPkXFRmI3OOC7EvN8=
X-Received: by 2002:a05:622a:1a15:b0:425:8959:8acb with SMTP id f21-20020a05622a1a1500b0042589598acbmr8904126qtb.43.1702412576325;
        Tue, 12 Dec 2023 12:22:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELQOKkgC/Btq9R+ReYVYGhzcQEPDc2duzV3sXEk7OC7JP4+Ail5L1gwRoiQi8fYvtQSA010Q==
X-Received: by 2002:a05:622a:1a15:b0:425:8959:8acb with SMTP id f21-20020a05622a1a1500b0042589598acbmr8904120qtb.43.1702412576008;
        Tue, 12 Dec 2023 12:22:56 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id t11-20020ac86a0b000000b00423b8a53641sm4334672qtr.29.2023.12.12.12.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:22:55 -0800 (PST)
Date: Tue, 12 Dec 2023 15:22:46 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/4] rteval: Refactor collapse_cpulist in systopology
In-Reply-To: <20231129093457.17984-2-tglozar@redhat.com>
Message-ID: <ecc75cd2-d064-1d3d-3bbd-30f736b62fa4@redhat.com>
References: <20231129093457.17984-1-tglozar@redhat.com> <20231129093457.17984-2-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 29 Nov 2023, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Instead of having duplicate code in two functions, one top-level and
> one member function of CpuList, have only one static function in
> CpuList.
> 
> Additionally re-write the implementation to use a more straight forward
> one-pass algorithm.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval-cmd                               |  4 +-
>  rteval/modules/loads/__init__.py         |  4 +-
>  rteval/modules/measurement/__init__.py   |  4 +-
>  rteval/modules/measurement/cyclictest.py |  6 +--
>  rteval/systopology.py                    | 68 ++++++++----------------
>  5 files changed, 30 insertions(+), 56 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index 6f613a3..7c41429 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -30,7 +30,7 @@ from rteval import RtEval, rtevalConfig
>  from rteval.modules.loads import LoadModules
>  from rteval.modules.measurement import MeasurementModules
>  from rteval.version import RTEVAL_VERSION
> -from rteval.systopology import CpuList, SysTopology, collapse_cpulist
> +from rteval.systopology import CpuList, SysTopology
>  from rteval.modules.loads.kcompile import ModuleParameters
>  
>  compress_cpulist = CpuList.compress_cpulist
> @@ -211,7 +211,7 @@ def remove_offline(cpulist):
>      """ return cpulist in collapsed compressed form with only online cpus """
>      tmplist = expand_cpulist(cpulist)
>      tmplist = SysTopology().online_cpulist(tmplist)
> -    return collapse_cpulist(tmplist)
> +    return CpuList.collapse_cpulist(tmplist)
>  
>  
>  if __name__ == '__main__':
> diff --git a/rteval/modules/loads/__init__.py b/rteval/modules/loads/__init__.py
> index aca0c9f..13fba1e 100644
> --- a/rteval/modules/loads/__init__.py
> +++ b/rteval/modules/loads/__init__.py
> @@ -11,7 +11,7 @@ import libxml2
>  from rteval.Log import Log
>  from rteval.rtevalConfig import rtevalCfgSection
>  from rteval.modules import RtEvalModules, rtevalModulePrototype
> -from rteval.systopology import collapse_cpulist, CpuList, SysTopology as SysTop
> +from rteval.systopology import CpuList, SysTopology as SysTop
>  
>  class LoadThread(rtevalModulePrototype):
>      def __init__(self, name, config, logger=None):
> @@ -120,7 +120,7 @@ class LoadModules(RtEvalModules):
>              cpulist = CpuList(cpulist).cpulist
>          else:
>              cpulist = SysTop().default_cpus()
> -        rep_n.newProp("loadcpus", collapse_cpulist(cpulist))
> +        rep_n.newProp("loadcpus", CpuList.collapse_cpulist(cpulist))
>  
>          return rep_n
>  
> diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
> index 2a0556b..41b8022 100644
> --- a/rteval/modules/measurement/__init__.py
> +++ b/rteval/modules/measurement/__init__.py
> @@ -5,7 +5,7 @@
>  
>  import libxml2
>  from rteval.modules import RtEvalModules, ModuleContainer
> -from rteval.systopology import collapse_cpulist, CpuList, SysTopology as SysTop
> +from rteval.systopology import CpuList, SysTopology as SysTop
>  
>  class MeasurementProfile(RtEvalModules):
>      """Keeps and controls all the measurement modules with the same measurement profile"""
> @@ -187,7 +187,7 @@ measurement profiles, based on their characteristics"""
>              cpulist = CpuList(cpulist).cpulist
>          else:
>              cpulist = SysTop().online_cpus() if run_on_isolcpus else SysTop().default_cpus()
> -        rep_n.newProp("measurecpus", collapse_cpulist(cpulist))
> +        rep_n.newProp("measurecpus", CpuList.collapse_cpulist(cpulist))
>  
>          for mp in self.__measureprofiles:
>              mprep_n = mp.MakeReport()
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index 0af1d31..1b14e7e 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -17,7 +17,7 @@ import libxml2
>  from rteval.Log import Log
>  from rteval.modules import rtevalModulePrototype
>  from rteval.systopology import cpuinfo
> -from rteval.systopology import CpuList, SysTopology, collapse_cpulist
> +from rteval.systopology import CpuList, SysTopology
>  
>  expand_cpulist = CpuList.expand_cpulist
>  
> @@ -203,7 +203,7 @@ class Cyclictest(rtevalModulePrototype):
>              # Only include online cpus
>              self.__cpus = CpuList(self.__cpus).cpulist
>              # Reset cpulist from the newly calculated self.__cpus
> -            self.__cpulist = collapse_cpulist(self.__cpus)
> +            self.__cpulist = CpuList.collapse_cpulist(self.__cpus)
>              self.__cpus = [str(c) for c in self.__cpus]
>              self.__sparse = True
>              if self.__run_on_isolcpus:
> @@ -220,7 +220,7 @@ class Cyclictest(rtevalModulePrototype):
>              self.__cpus = [c for c in self.__cpus if c in cpuset or self.__run_on_isolcpus and c in isolcpus]
>              if self.__run_on_isolcpus:
>                  self.__sparse = True
> -                self.__cpulist = collapse_cpulist(self.__cpus)
> +                self.__cpulist = CpuList.collapse_cpulist([int(c) for c in self.__cpus])
>  
>          # Sort the list of cpus to align with the order reported by cyclictest
>          self.__cpus.sort(key=int)
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index 62ad355..ea8e242 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -10,25 +10,6 @@ import os
>  import os.path
>  import glob
>  
> -# Utility version of collapse_cpulist that doesn't require a CpuList object
> -def collapse_cpulist(cpulist):
> -    """ Collapse a list of cpu numbers into a string range
> -        of cpus (e.g. 0-5, 7, 9) """
> -    if len(cpulist) == 0:
> -        return ""
> -    idx = CpuList.longest_sequence(cpulist)
> -    if idx == 0:
> -        seq = str(cpulist[0])
> -    else:
> -        if idx == 1:
> -            seq = f"{cpulist[0]},{cpulist[idx]}"
> -        else:
> -            seq = f"{cpulist[0]}-{cpulist[idx]}"
> -
> -    rest = collapse_cpulist(cpulist[idx+1:])
> -    if rest == "":
> -        return seq
> -    return ",".join((seq, rest))
>  
>  def sysread(path, obj):
>      """ Helper function for reading system files """
> @@ -93,7 +74,7 @@ class CpuList:
>          self.cpulist.sort()
>  
>      def __str__(self):
> -        return self.__collapse_cpulist(self.cpulist)
> +        return self.collapse_cpulist(self.cpulist)
>  
>      def __contains__(self, cpu):
>          return cpu in self.cpulist
> @@ -114,35 +95,28 @@ class CpuList:
>          return os.path.exists(os.path.join(CpuList.cpupath, "isolated"))
>  
>      @staticmethod
> -    def longest_sequence(cpulist):
> -        """ return index of last element of a sequence that steps by one """
> -        lim = len(cpulist)
> -        for idx, _ in enumerate(cpulist):
> -            if idx+1 == lim:
> -                break
> -            if int(cpulist[idx+1]) != (int(cpulist[idx])+1):
> -                return idx
> -        return lim - 1
> -
> -    def __collapse_cpulist(self, cpulist):
> -        """ Collapse a list of cpu numbers into a string range
> +    def collapse_cpulist(cpulist):
> +        """
> +        Collapse a list of cpu numbers into a string range
>          of cpus (e.g. 0-5, 7, 9)
>          """
> -        if len(cpulist) == 0:
> -            return ""
> -        idx = self.longest_sequence(cpulist)
> -        if idx == 0:
> -            seq = str(cpulist[0])
> -        else:
> -            if idx == 1:
> -                seq = f"{cpulist[0]},{cpulist[idx]}"
> +        cur_range = [None, None]
> +        result = []
> +        for cpu in cpulist + [None]:
> +            if cur_range[0] is None:
> +                cur_range[0] = cur_range[1] = cpu
> +                continue
> +            if cpu is not None and cpu == cur_range[1] + 1:
> +                # Extend currently processed range
> +                cur_range[1] += 1
>              else:
> -                seq = f"{cpulist[0]}-{cpulist[idx]}"
> -
> -        rest = self.__collapse_cpulist(cpulist[idx+1:])
> -        if rest == "":
> -            return seq
> -        return ",".join((seq, rest))
> +                # Range processing finished, add range to string
> +                result.append(f"{cur_range[0]}-{cur_range[1]}"
> +                              if cur_range[0] != cur_range[1]
> +                              else str(cur_range[0]))
> +                # Reset
> +                cur_range[0] = cur_range[1] = cpu
> +        return ",".join(result)
>  
>      @staticmethod
>      def compress_cpulist(cpulist):
> @@ -428,7 +402,7 @@ if __name__ == "__main__":
>  
>          onlcpus = s.online_cpus()
>          print(f'onlcpus = {onlcpus}')
> -        onlcpus = collapse_cpulist(onlcpus)
> +        onlcpus = CpuList.collapse_cpulist(onlcpus)
>          print(f'onlcpus = {onlcpus}')
>  
>          onlcpus_str = s.online_cpus_str()
> -- 
> 2.39.3
> 

I don't necessarily find the iterative version of the function more 
readable than the recursive one, although I'm sure it is more 
efficient. This is all fine, although not all the refractoring here
is necessary to implement the new feature. Sometimes I would
prefer those efforts to come later.

Signed-off-by: John Kacur <jkacur@redhat.com>

