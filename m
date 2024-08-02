Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D21547C3
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Aug 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625015; cv=none; b=Q8QFmoY6M++KtHKTUTa4ZVmhhuV4a34jps0OfOLUmWPZwam/F16X5Y1Qb4JOPgJCKjJoxzNYgPLLIvclj84qmY7L00/hV7ssh78inls3tkC7Ehha9c8ErdNPMfk4g/V8fH3vj2Q0GBd0xDWA+fTPysyBuYr0u58D+q1vQov1CqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625015; c=relaxed/simple;
	bh=VbbMzBb+5nS4yuM7sNeTRIR/ZOf+jm31J4nlTsPW8Ac=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cw7YkUpOwV8xu7v9inpeA9obs+nlJTfMJ4udh9jRPjnpOBZpkv1Fj7yilcfSr/oAfvk07LQExSt8n13wAKj5ebytIQ2QyKFubPkaZjreXiGVK/YvigLyiVG/D4Fu0q2Llwao30HjiTttHKut2sFtZ9+K4cKzPGW+Fa9rlHUMfTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfvjJi3t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfvjJi3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722625012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ndvzmdhEH2shp9kaybTClT6hCU3FG4rwVmPgVxS9sds=;
	b=ZfvjJi3t6yEXpzBnWkScaxAlfBiJo7HLu5xOZ6GqwEvKE4YfVlmM4QR7FyCczl+yI+yze2
	DZFrr9xalMmACqCriDx0b8C3efOWP4LbkUJrZ/bHGm94BwZfgDHa1X66EDFHHZaUXx/6e6
	9aBzbVf/zmeqpfWSWsfpTFamseetUBo=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-h3XEVzTAPcy1YNTn0EywVw-1; Fri, 02 Aug 2024 14:56:51 -0400
X-MC-Unique: h3XEVzTAPcy1YNTn0EywVw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5d5ffdc9ed9so5150511eaf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Aug 2024 11:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722625010; x=1723229810;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndvzmdhEH2shp9kaybTClT6hCU3FG4rwVmPgVxS9sds=;
        b=CVlOT+TdnE/enLmGhqFc95CFRe/+ekwxYptWI65Ny3wExcX1fJh3E0sMMZ+2E1FgjW
         bKdQtH6+KcIf8f2cl9wsR/RT2RJpk8kDSvptO5tr+11EL26wYTyAaR3EsT6vT5UyaABs
         pifHYUTvSq1BxzSoqd2WNkgQJnUJYYrp8bI3q18AxYsrzh5Xi0Ht+aaeK/f6xFxAa/wu
         Xg95EHr2+oKthsxThWNWnLhPZS04bWLSq2DZyMSexCB9u0oqu5iu4dWqEg8DP/bdnLRm
         k2bG4nLGwz1CpkcZyl6iqhY4R8vWcKeC5HPc2blKFzB4Tv1sjByQgI2dWIfhUhR1C1Tk
         RXLQ==
X-Gm-Message-State: AOJu0YyFEeuufKXK6077MWd+E7lIDNkhPyxy1yrWc6fIKY2Jg7lwmeO5
	8s7hDXf3MKNx7vaaRCnk5yqOTyI96omV02lVXiyDZxoo+mzX8f6vhVFGPbOybmD0mztm2+OVwkW
	FX7O8HCcv606lSeu08lnM2jeKx0cWkb7xR237nbHIKi4sjqh9tQSB4bhaBQzuWV8qYVR0rYIm
X-Received: by 2002:a05:6358:c117:b0:1ad:d2a:75ea with SMTP id e5c5f4694b2df-1af3bad7725mr372047755d.14.1722625009630;
        Fri, 02 Aug 2024 11:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4Hjv/H8uwNg4P0i71dwDg1h9cqXQHpyWIwDpi0pDw+LjfoKvDNZhPNubdj6/9K4n7PCaVwQ==
X-Received: by 2002:a05:6358:c117:b0:1ad:d2a:75ea with SMTP id e5c5f4694b2df-1af3bad7725mr372046255d.14.1722625009196;
        Fri, 02 Aug 2024 11:56:49 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c76aceasm9534836d6.6.2024.08.02.11.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:56:48 -0700 (PDT)
Date: Fri, 2 Aug 2024 14:56:47 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rteval: Add module for tuned state
In-Reply-To: <20240724073742.58006-1-tglozar@redhat.com>
Message-ID: <9162269f-911c-e8df-c746-e641001de8e0@redhat.com>
References: <20240724073742.58006-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 24 Jul 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Add a sysinfo module for collecting the tuned state. Three properties
> are collected:
> - whether tuned is present
> - what the active tuned profile is
> - whether tuned profile verification passes
> 
> In case of a failed verification, the tuned log is also collected.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/sysinfo/__init__.py |   5 +-
>  rteval/sysinfo/tuned.py    | 191 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 195 insertions(+), 1 deletion(-)
>  create mode 100644 rteval/sysinfo/tuned.py
> 
> diff --git a/rteval/sysinfo/__init__.py b/rteval/sysinfo/__init__.py
> index 09af52e..4b7b03c 100644
> --- a/rteval/sysinfo/__init__.py
> +++ b/rteval/sysinfo/__init__.py
> @@ -15,10 +15,11 @@ from rteval.sysinfo.memory import MemoryInfo
>  from rteval.sysinfo.osinfo import OSInfo
>  from rteval.sysinfo.newnet import NetworkInfo
>  from rteval.sysinfo.cmdline import cmdlineInfo
> +from rteval.sysinfo.tuned import TunedInfo
>  from rteval.sysinfo import dmi
>  
>  class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
> -                 MemoryInfo, OSInfo, NetworkInfo, cmdlineInfo):
> +                 MemoryInfo, OSInfo, NetworkInfo, cmdlineInfo, TunedInfo):
>      def __init__(self, config, logger=None):
>          self.__logger = logger
>          KernelInfo.__init__(self, logger=logger)
> @@ -28,6 +29,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
>          OSInfo.__init__(self, logger=logger)
>          cmdlineInfo.__init__(self, logger=logger)
>          NetworkInfo.__init__(self, logger=logger)
> +        TunedInfo.__init__(self, logger=logger)
>  
>          # Parse initial DMI decoding errors
>          self.ProcessWarnings()
> @@ -49,6 +51,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
>          report_n.addChild(MemoryInfo.MakeReport(self))
>          report_n.addChild(dmi.DMIinfo.MakeReport(self))
>          report_n.addChild(cmdlineInfo.MakeReport(self))
> +        report_n.addChild(TunedInfo.MakeReport(self))
>  
>          return report_n
>  
> diff --git a/rteval/sysinfo/tuned.py b/rteval/sysinfo/tuned.py
> new file mode 100644
> index 0000000..063fcbf
> --- /dev/null
> +++ b/rteval/sysinfo/tuned.py
> @@ -0,0 +1,191 @@
> +# -*- coding: utf-8 -*-
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +#   Copyright 2024          Tomas Glozar <tglozar@redhat.com>
> +#
> +"""tuned sysinfo module"""
> +import shutil
> +import subprocess
> +import sys
> +import libxml2
> +from rteval.Log import Log
> +
> +TUNED_ADM = "tuned-adm"
> +TUNED_LOG_PATH = "/var/log/tuned/tuned.log"
> +TUNED_VERIFY_START_LINE = "INFO     tuned.daemon.daemon: verifying " \
> +                          "profile(s): realtime"
> +
> +
> +def tuned_present():
> +    """
> +    Checks if tuned is present on the system
> +    :return: True if tuned is present, False otherwise
> +    """
> +    return shutil.which(TUNED_ADM) is not None
> +
> +
> +def tuned_active_profile():
> +    """
> +    Gets tuned active profile.
> +    :return: Tuned profile (as a string) or "unknown"
> +    """
> +    try:
> +        result = subprocess.check_output([TUNED_ADM, "active"])
> +    except (OSError, subprocess.CalledProcessError):
> +        return "unknown"
> +    result = result.decode("utf-8")
> +    split_result = result.split(": ")
> +    if len(split_result) < 2:
> +        return "unknown"
> +    return split_result[1].strip()
> +
> +
> +def tuned_verify():
> +    """
> +    Verifies if tuned profile is applied properly
> +    :return: "success", "failure" or "unknown"
> +    """
> +    try:
> +        result = subprocess.run([TUNED_ADM, "verify"],
> +                                stdout=subprocess.PIPE, check=False).stdout
> +    except (OSError, subprocess.CalledProcessError):
> +        return "unknown"
> +    result = result.decode("utf-8")
> +    if result.startswith("Verification succeeded"):
> +        return "success"
> +    if result.startswith("Verification failed"):
> +        return "failure"
> +    return "unknown"
> +
> +
> +def tuned_get_log():
> +    """
> +    Read entries related to last profile verification from tuned log
> +    :return: List of strings containing the entires, or None if no
> +    verification is found in the log
> +    """
> +    try:
> +        with open(TUNED_LOG_PATH, "r", encoding="utf-8") as file:
> +            lines = file.readlines()
> +            # Find start of last verification
> +            start = None
> +            for i in reversed(range(len(lines))):
> +                if TUNED_VERIFY_START_LINE in lines[i]:
> +                    start = i
> +                    break
> +            if start is None:
> +                return None
> +            return lines[start:]
> +    except OSError:
> +        return None
> +
> +
> +class TunedInfo:
> +    """
> +    Gather information about tuned and make an XML report.
> +    Collected information:
> +    - whether tuned is present
> +    - which tuned profile is active
> +    - whether the tuned profile is applied correctly
> +    - if not applied correctly, collect relevant info from log
> +    """
> +    def __init__(self, logger=None):
> +        self.__logger = logger
> +
> +    def __log(self, logtype, msg):
> +        if self.__logger:
> +            self.__logger.log(logtype, msg)
> +
> +    def tuned_state_get(self):
> +        """
> +        Gets the state of tuned on the machine
> +        :return: A dictionary describing the tuned state
> +        """
> +        result = {
> +            "present": tuned_present()
> +        }
> +        if not result["present"]:
> +            self.__log(Log.DEBUG, "tuned-adm not found; skipping tuned "
> +                                  "sysinfo collection")
> +            return result
> +        result["active_profile"] = tuned_active_profile()
> +        if result["active_profile"] == "unknown":
> +            self.__log(Log.DEBUG, "could not retrieve tuned active profile")
> +            return result
> +        result["verified"] = tuned_verify()
> +        if result["verified"] == "unknown":
> +            self.__log(Log.DEBUG, "could not verify tuned state")
> +        if result["verified"] == "failure":
> +            # Include log to see cause to failure
> +            result["verification_log"] = tuned_get_log()
> +
> +        return result
> +
> +    def MakeReport(self):
> +        """
> +        Create XML report
> +        :return: libxml2 node containing the report
> +        """
> +        tuned = self.tuned_state_get()
> +
> +        rep_n = libxml2.newNode("Tuned")
> +        rep_n.newProp("present", str(int(tuned["present"])))
> +        for key, value in tuned.items():
> +            if key == "present":
> +                continue
> +            child = libxml2.newNode(key)
> +            if key == "verification_log":
> +                if value is None:
> +                    self.__log(Log.WARN, "could not get verification log")
> +                    continue
> +                for line in value:
> +                    # <date> <time> <log-level>    <message>
> +                    line = line.split(" ", 3)
> +                    if len(line) != 4:
> +                        continue
> +                    line_child = libxml2.newNode("entry")
> +                    line_child.newProp("date", line[0])
> +                    line_child.newProp("time", line[1])
> +                    line_child.newProp("level", line[2])
> +                    line_child.setContent(line[3].strip())
> +                    child.addChild(line_child)
> +            else:
> +                child.setContent(value)
> +            rep_n.addChild(child)
> +
> +        return rep_n
> +
> +
> +def unit_test(rootdir):
> +    try:
> +        # Helper function tests
> +        result = tuned_present()
> +        print("tuned present:", result)
> +        assert isinstance(result, bool), "__tuned_present() should return bool"
> +        result = tuned_active_profile()
> +        print("tuned active profile:", result)
> +        assert isinstance(result, str), "__tuned_active_profile() should " \
> +                                        "return string"
> +        result = tuned_verify()
> +        print("tuned verification state:", result)
> +        assert isinstance(result, str), "__tuned_verify() should return string"
> +        result = tuned_get_log()
> +        assert isinstance(result, list) or result is None, \
> +            "__tuned_get_log() should return list or None"
> +
> +        # Class tests
> +        tuned = TunedInfo()
> +        result = tuned.tuned_state_get()
> +        print(result)
> +        assert isinstance(result, dict), "TunedInfo.tuned_state_get() " \
> +                                         "should return dict"
> +        tuned.MakeReport()
> +
> +        return 0
> +    except Exception as err:
> +        print(f"** EXCEPTION: {str(err)}")
> +        return 1
> +
> +
> +if __name__ == '__main__':
> +    sys.exit(unit_test(None))
> -- 

Thanks!
Signed-off-by: John Kacur <jkacur@redhat.com>

Note: awaiting a follow-up patch to include the information in the final 
report as we discussed offline

