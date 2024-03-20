Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C84535C2
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Mar 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950336; cv=none; b=J2FZ1QIZGw9O31yqVAGTsHSb94BbiiPxo/YCBa9MYSeqhmEqQBx6y4biFgho4R6hwrtdTX9SmAOxLSkS1i29FYVf1+pLgXMLudL7kMLX5XExNsniJlTlq1W3VQcpf4Zxh55Q6aPxv6+mN4/vWP4XSoSqNSv0abtkbv2fYShjrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950336; c=relaxed/simple;
	bh=Syf7buK6IEDBv6ot5wIL4LPRxQKrSCTRXVBn1EyT8Ak=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kS0zhMTHzTv06OasR7vNI+5xNalotadnoBRKNBSOulkQLuvQawhImAe1zYm+84FUiM5iI1qH+rLrpKFJxCEtU+cCCaRJ5PTXcdcklfmgDLTM6Czo9QC37uWpP0uhxIQei68hoakuAMl/tVeVQHYdytg0MuLBtcNT7fGTtYa6/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csZJf7HG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csZJf7HG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710950333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAPgQhrRsWY5iP0cL+PGajjCvUuMBfOvDaP2osTSrFI=;
	b=csZJf7HGKodl8yy2bdIfJCUPbmHtj9RoY3aGVA6/MDl0zj7wgr7aGEdNcMRxLp3sB7qrEK
	6+519+8PpK3VpfZT0iBESGp76NXKTDpecNI7Dt+7/xRGw5lxjU+KugsL+xDBTlJRF7SOWl
	tLRa16uiqC6kjVQVeJnob63Mkvv5Vqg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-CeZ5Tka0OdC_UJt9C2RvmA-1; Wed, 20 Mar 2024 11:58:51 -0400
X-MC-Unique: CeZ5Tka0OdC_UJt9C2RvmA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-430baecb018so72671cf.2
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Mar 2024 08:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710950331; x=1711555131;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAPgQhrRsWY5iP0cL+PGajjCvUuMBfOvDaP2osTSrFI=;
        b=jTo3cYk4v3Gx/WiXGM/VbIq6gB7WE2f/fzr/Eb4O4NyEVs+9w3kOrYH1+eUjfRjEHP
         r55wn+vt62cuOypH0oL8sRX6tWeNKfiRtY/lJLJgb9+5rtCyQtQYcf8N5+141FISRtd5
         mBVL/pAeRLHeTKqrMFaR1LCYVarRHHdWwU+7o6rA8ARYhSjCVQHQsjNXi3bm8CKhnSs6
         CJ2yooknEhcvHy3/05CJanNJRl5DDNB7pkqZF8G9EHrNlsthzZBp/PJlCQZJ10aINEti
         QWByBuvvWXBklRoZjU+k3BsWy2XBZKd0b2cIvubn6E0KSg/12Sz5xLM09ZHfsr1/lst1
         rkrA==
X-Gm-Message-State: AOJu0YwlplN/mtgT9s/XWX0M+DkVmILYZ8KFZwvtOyMV1qr5vO1J/3l+
	7MttVlM5PqQ2+82GWLHwr8dUWQKOvrpU8cyI567imnVJ+Wagkl7q2ktJixCcalwRhEMqDc8QyX2
	ilJq8typK+KksT/5k0hPGWHpkHxXFLeApUDfvTFlU3jT9ITLKWZ0fDL9JhkJFT8Wp
X-Received: by 2002:a05:622a:40b:b0:430:95e4:7c12 with SMTP id n11-20020a05622a040b00b0043095e47c12mr20516171qtx.55.1710950331242;
        Wed, 20 Mar 2024 08:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI1oi/4N7QvUyrNAmueFh8t0Ipe5CARUrmg2GbZZOOQaK+FgzeFRwgHVaKqMxveuZJkNBj0w==
X-Received: by 2002:a05:622a:40b:b0:430:95e4:7c12 with SMTP id n11-20020a05622a040b00b0043095e47c12mr20516149qtx.55.1710950330875;
        Wed, 20 Mar 2024 08:58:50 -0700 (PDT)
Received: from fionn ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id cc5-20020a05622a410500b0042f3ee1443csm4120406qtb.10.2024.03.20.08.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:58:50 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:58:41 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Implement initial dmidecode support
In-Reply-To: <20240304102603.89558-1-tglozar@redhat.com>
Message-ID: <fd5b0cd6-ab4c-88d7-ac7d-4450d06b0e44@redhat.com>
References: <20240304102603.89558-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 4 Mar 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Previously rteval used python-dmidecode to gather DMI data from a
> system. Since python-dmidecode is without a maintainer, its support was
> removed in d142f0d2 ("rteval: Disable use of python-dmidecode").
> 
> Add get_dmidecode_xml() function into rteval/sysinfo/dmi.py that does
> simple parsing of dmidecode command-line tool output without any
> structure changes and include it into the rteval report.
> 
> Notes:
> - ProcessWarnings() in rteval.sysinfo.dmi was reworked into a class
>   method of DMIinfo and to use the class's __log field as logger. It
>   now also does not ignore warnings that appear when running rteval as
>   non-root, since that is no longer supported. Additionally,
>   a duplicate call in rteval-cmd was removed.
> - rteval/rteval_dmi.xsl XSLT template was left untouched and is
>   currectly not used. In a future commit, it is expected to be rewritten
>   to transform the XML format outputted by get_dmidecode_xml() into the
>   same format that was used with python-dmidecode.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval-cmd                 |   2 -
>  rteval/sysinfo/__init__.py |   2 +-
>  rteval/sysinfo/dmi.py      | 178 ++++++++++++++++++++++++-------------
>  3 files changed, 118 insertions(+), 64 deletions(-)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index a5e8746..018a414 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -268,8 +268,6 @@ if __name__ == '__main__':
>                  | (rtevcfg.debugging and Log.DEBUG)
>          logger.SetLogVerbosity(loglev)
>  
> -        dmi.ProcessWarnings(logger=logger)
> -
>          # Load modules
>          loadmods = LoadModules(config, logger=logger)
>          measuremods = MeasurementModules(config, logger=logger)
> diff --git a/rteval/sysinfo/__init__.py b/rteval/sysinfo/__init__.py
> index d3f9efb..09af52e 100644
> --- a/rteval/sysinfo/__init__.py
> +++ b/rteval/sysinfo/__init__.py
> @@ -30,7 +30,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
>          NetworkInfo.__init__(self, logger=logger)
>  
>          # Parse initial DMI decoding errors
> -        dmi.ProcessWarnings(logger=logger)
> +        self.ProcessWarnings()
>  
>          # Parse CPU info
>          CPUtopology._parse(self)
> diff --git a/rteval/sysinfo/dmi.py b/rteval/sysinfo/dmi.py
> index c01a0ee..f1aab9f 100644
> --- a/rteval/sysinfo/dmi.py
> +++ b/rteval/sysinfo/dmi.py
> @@ -3,6 +3,7 @@
>  #   Copyright 2009 - 2013   Clark Williams <williams@redhat.com>
>  #   Copyright 2009 - 2013   David Sommerseth <davids@redhat.com>
>  #   Copyright 2022          John Kacur <jkacur@redhat.com>
> +#   Copyright 2024          Tomas Glozar <tglozar@redhat.com>
>  #
>  """ dmi.py class to wrap DMI Table Information """
>  
> @@ -10,65 +11,125 @@ import sys
>  import os
>  import libxml2
>  import lxml.etree
> +import shutil
> +import re
> +from subprocess import Popen, PIPE, SubprocessError
>  from rteval.Log import Log
>  from rteval import xmlout
>  from rteval import rtevalConfig
>  
> -try:
> -    # import dmidecode
> -    dmidecode_avail = False
> -except ModuleNotFoundError:
> -    dmidecode_avail = False
> -
> -def set_dmidecode_avail(val):
> -    """ Used to set global variable dmidecode_avail from a function """
> -    global dmidecode_avail
> -    dmidecode_avail = val
> -
> -def ProcessWarnings(logger=None):
> -    """ Process Warnings from dmidecode """
> -
> -    if not dmidecode_avail:
> -        return
> -
> -    if not hasattr(dmidecode, 'get_warnings'):
> -        return
> -
> -    warnings = dmidecode.get_warnings()
> -    if warnings is None:
> -        return
> -
> -    ignore1  = '/dev/mem: Permission denied'
> -    ignore2 = 'No SMBIOS nor DMI entry point found, sorry.'
> -    ignore3 = 'Failed to open memory buffer (/dev/mem): Permission denied'
> -    ignore = (ignore1, ignore2, ignore3)
> -    for warnline in warnings.split('\n'):
> -        # Ignore these warnings, as they are "valid" if not running as root
> -        if warnline in ignore:
> -            continue
>  
> -        # All other warnings will be printed
> -        if len(warnline) > 0:
> -            logger.log(Log.DEBUG, f"** DMI WARNING ** {warnline}")
> -            set_dmidecode_avail(False)
> +def get_dmidecode_xml(dmidecode_executable):
> +    """
> +    Transform human-readable dmidecode output into machine-processable XML format
> +    :param dmidecode_executable: Path to dmidecode tool executable
> +    :return: Tuple of values with resulting XML and dmidecode warnings
> +    """
> +    proc = Popen(dmidecode_executable, text=True, stdout=PIPE, stderr=PIPE)
> +    outs, errs = proc.communicate()
> +    parts = outs.split("\n\n")
> +    if len(parts) < 2:
> +        raise RuntimeError("Parsing dmidecode output failed")
> +    header = parts[0]
> +    handles = parts[1:]
> +    root = lxml.etree.Element("dmidecode")
> +    # Parse dmidecode output header
> +    # Note: Only supports SMBIOS data currently
> +    regex = re.compile(r"# dmidecode (\d+\.\d+)\n"
> +                       r"Getting SMBIOS data from sysfs\.\n"
> +                       r"SMBIOS ((?:\d+\.)+\d+) present\.\n"
> +                       r"(?:(\d+) structures occupying (\d+) bytes\.\n)?"
> +                       r"Table at (0x[0-9A-Fa-f]+)\.", re.MULTILINE)
> +    match = re.match(regex, header)
> +    if match is None:
> +        raise RuntimeError("Parsing dmidecode output failed")
> +    root.attrib["dmidecodeversion"] = match.group(1)
> +    root.attrib["smbiosversion"] = match.group(2)
> +    if match.group(3) is not None:
> +        root.attrib["structures"] = match.group(3)
> +    if match.group(4) is not None:
> +        root.attrib["size"] = match.group(4)
> +    root.attrib["address"] = match.group(5)
> +
> +    # Generate element per handle in dmidecode output
> +    for handle_text in handles:
> +        if not handle_text:
> +            # Empty line
> +            continue
>  
> -    dmidecode.clear_warnings()
> +        handle = lxml.etree.Element("Handle")
> +        lines = handle_text.splitlines()
> +        # Parse handle header
> +        if len(lines) < 2:
> +            raise RuntimeError("Parsing dmidecode handle failed")
> +        header, name, content = lines[0], lines[1], lines[2:]
> +        match = re.match(r"Handle (0x[0-9A-Fa-f]{4}), "
> +                         r"DMI type (\d+), (\d+) bytes", header)
> +        if match is None:
> +            raise RuntimeError("Parsing dmidecode handle failed")
> +        handle.attrib["address"] = match.group(1)
> +        handle.attrib["type"] = match.group(2)
> +        handle.attrib["bytes"] = match.group(3)
> +        handle.attrib["name"] = name
> +
> +        # Parse all fields in handle and create an element for each
> +        list_field = None
> +        for index, line in enumerate(content):
> +            line = content[index]
> +            if line.rfind("\t") > 0:
> +                # We are inside a list field, add value to it
> +                value = lxml.etree.Element("Value")
> +                value.text = line.strip()
> +                list_field.append(value)
> +                continue
> +            line = line.lstrip().split(":", 1)
> +            if len(line) != 2:
> +                raise RuntimeError("Parsing dmidecode field failed")
> +            if not line[1] or (index + 1 < len(content) and
> +                               content[index + 1].rfind("\t") > 0):
> +                # No characters after : or next line is inside list field
> +                # means a list field
> +                # Note: there are list fields which specify a number of
> +                # items, for example "Installable Languages", so merely
> +                # checking for no characters after : is not enough
> +                list_field = lxml.etree.Element("List")
> +                list_field.attrib["Name"] = line[0].strip()
> +                handle.append(list_field)
> +            else:
> +                # Regular field
> +                field = lxml.etree.Element("Field")
> +                field.attrib["Name"] = line[0].strip()
> +                field.text = line[1].strip()
> +                handle.append(field)
> +
> +        root.append(handle)
> +
> +    return root, errs
>  
>  
>  class DMIinfo:
> -    '''class used to obtain DMI info via python-dmidecode'''
> +    '''class used to obtain DMI info via dmidecode'''
>  
>      def __init__(self, logger=None):
>          self.__version = '0.6'
>          self._log = logger
>  
> -        if not dmidecode_avail:
> -            logger.log(Log.DEBUG, "DMI info unavailable, ignoring DMI tables")
> +        dmidecode_executable = shutil.which("dmidecode")
> +        if dmidecode_executable is None:
> +            logger.log(Log.DEBUG, "DMI info unavailable,"
> +                                  " ignoring DMI tables")
>              self.__fake = True
>              return
>  
>          self.__fake = False
> -        self.__dmixml = dmidecode.dmidecodeXML()
> +        try:
> +            self.__dmixml, self.__warnings = get_dmidecode_xml(
> +                dmidecode_executable)
> +        except (RuntimeError, OSError, SubprocessError) as error:
> +            logger.log(Log.DEBUG, "DMI info unavailable: {};"
> +                                  " ignoring DMI tables".format(str(error)))
> +            self.__fake = True
> +            return
>  
>          self.__xsltparser = self.__load_xslt('rteval_dmi.xsl')
>  
> @@ -88,30 +149,25 @@ class DMIinfo:
>  
>          raise RuntimeError(f'Could not locate XSLT template for DMI data ({fname})')
>  
> +    def ProcessWarnings(self):
> +        """Prints out warnings from dmidecode into log if there were any"""
> +        if self.__fake or self._log is None:
> +            return
> +        for warnline in self.__warnings.split('\n'):
> +            if len(warnline) > 0:
> +                self._log.log(Log.DEBUG, f"** DMI WARNING ** {warnline}")
> +
>      def MakeReport(self):
>          """ Add DMI information to final report """
> -        rep_n = libxml2.newNode("DMIinfo")
> -        rep_n.newProp("version", self.__version)
>          if self.__fake:
> +            rep_n = libxml2.newNode("DMIinfo")
> +            rep_n.newProp("version", self.__version)
>              rep_n.addContent("No DMI tables available")
>              rep_n.newProp("not_available", "1")
> -        else:
> -            self.__dmixml.SetResultType(dmidecode.DMIXML_DOC)
> -            try:
> -                dmiqry = xmlout.convert_libxml2_to_lxml_doc(self.__dmixml.QuerySection('all'))
> -            except Exception as ex1:
> -                self._log.log(Log.DEBUG, f'** EXCEPTION {str(ex1)}, will query BIOS only')
> -                try:
> -                    # If we can't query 'all', at least query 'bios'
> -                    dmiqry = xmlout.convert_libxml2_to_lxml_doc(self.__dmixml.QuerySection('bios'))
> -                except Exception as ex2:
> -                    rep_n.addContent("No DMI tables available")
> -                    rep_n.newProp("not_available", "1")
> -                    self._log.log(Log.DEBUG, f'** EXCEPTION {str(ex2)}, dmi info will not be reported')
> -                    return rep_n
> -            resdoc = self.__xsltparser(dmiqry)
> -            dmi_n = xmlout.convert_lxml_to_libxml2_nodes(resdoc.getroot())
> -            rep_n.addChild(dmi_n)
> +            return rep_n
> +        rep_n = xmlout.convert_lxml_to_libxml2_nodes(self.__dmixml)
> +        rep_n.setName("DMIinfo")
> +        rep_n.newProp("version", self.__version)
>          return rep_n
>  
>  def unit_test(rootdir):
> @@ -130,12 +186,12 @@ def unit_test(rootdir):
>          log = Log()
>          log.SetLogVerbosity(Log.DEBUG|Log.INFO)
>  
> -        ProcessWarnings(logger=log)
>          if os.getuid() != 0:
>              print("** ERROR **  Must be root to run this unit_test()")
>              return 1
>  
>          d = DMIinfo(logger=log)
> +        d.ProcessWarnings()
>          dx = d.MakeReport()
>          x = libxml2.newDoc("1.0")
>          x.setRootElement(dx)
> -- 
Signed-off-by: John Kacur <jkacur@redhat.com>

