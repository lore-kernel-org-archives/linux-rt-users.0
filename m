Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD9BEB64D7
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jun 2023 20:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjF1Umc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjF1Uma (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jun 2023 16:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203941FF6
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687984898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdXE6D5LOOaAVx4uIYJVwtVASdivWnpCV8nmjfqJ3Wc=;
        b=IfLn3PUmzM7BDmqvX/eRlZmhwTNeLgeWp+ylKYcs0FG/wma6di54Uvd26icCugiFarnyPF
        ivdZD7pRUpGJMarIrpUwUwMIZIeD3m4IBWwNpHwvcjIcKBEMgy1DYYYdY2tY2jrbQC+8wm
        z5l/Z4suXKFO90DZ3H1k0VAIs9OFif0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-xnVokrY0O12E_7JC6oP6iA-1; Wed, 28 Jun 2023 16:41:34 -0400
X-MC-Unique: xnVokrY0O12E_7JC6oP6iA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635325b87c9so747836d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jun 2023 13:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984890; x=1690576890;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdXE6D5LOOaAVx4uIYJVwtVASdivWnpCV8nmjfqJ3Wc=;
        b=VSnccqFbqv27lDrx+wftcG/k+RiVSSiDZzxrSgs1S+JIRpmCYc0ZqI+AgsprmuuC3p
         1IWXDfweSG6u4BAtxyPiRA+4Bg/asFSftOpi5sax4P0r5D2d8r3Ra9SBoE8iLt/EyZYU
         yBnU6JdSma972Cbxk+W8wVD5yhOodLwNsWwSTglZkp7wbqdCscdg/wNEobun+rP/iHj4
         wfA8/UMbnu8Ku4KSqrvxNpwlyMQqUaW4mt78IrSIbhczSljgFTTDQrPuYmvcJZjVzR44
         J3II3nhvZOIr+jdiNRAWkCL1S7UZzwfG2c7lwwnsd6npyxP5nb/HMp13edwfcQHPaqXN
         JvSw==
X-Gm-Message-State: AC+VfDzW7C1D8DqMCNATUVWfY/5Ol9CeN48dvAo67iNhcpf3Aar9gBEL
        Pu+XfhKnHYKB+s/eM7cWrd2BX0puvD1aeZGshtzhjR4EXm0MRCdfXr5opRHLH83QE30g5G3lOhx
        7KeqEPA57Kvj+AHNC8/Gx2y/md/rqxxH4kWY=
X-Received: by 2002:ad4:5c6f:0:b0:635:d10b:aeb0 with SMTP id i15-20020ad45c6f000000b00635d10baeb0mr14864665qvh.57.1687984890542;
        Wed, 28 Jun 2023 13:41:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gLFncKpUkoGAC3m20JQeTCifxzHE2r4qnV+WR4vx0Mh06m0QByXdw0vZXSZ6FZhWFIR9mxQ==
X-Received: by 2002:ad4:5c6f:0:b0:635:d10b:aeb0 with SMTP id i15-20020ad45c6f000000b00635d10baeb0mr14864657qvh.57.1687984890298;
        Wed, 28 Jun 2023 13:41:30 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id pm16-20020ad446d0000000b00635f0a935casm2409818qvb.56.2023.06.28.13.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:41:30 -0700 (PDT)
Date:   Wed, 28 Jun 2023 16:41:29 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/3] rteval/server: edited files to use optparse instead
 of argparse
In-Reply-To: <20230628195145.636652-4-ashelat@redhat.com>
Message-ID: <62f9af1-a92-c913-cc4d-71eae2b511b@redhat.com>
References: <20230628195145.636652-1-ashelat@redhat.com> <20230628195145.636652-4-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 28 Jun 2023, Anubhav Shelat wrote:

> rteval/server: edited files to use optparse instead of argparse.
> Note: Since server is diabled, these changes have not been tested.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  server/remove_rtevalrun          | 16 ++++++++--------
>  server/rteval_testserver.py      |  1 -
>  server/testclient_sendreportfile | 10 +++++-----
>  3 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/server/remove_rtevalrun b/server/remove_rtevalrun
> index cee699e27c9f..7d83f71ea644 100755
> --- a/server/remove_rtevalrun
> +++ b/server/remove_rtevalrun
> @@ -29,7 +29,7 @@
>  
>  import sys
>  import getpass
> -from optparse import OptionParser
> +from argparse import ArgumentParser
>  from database import Database
>  
>  def do_delete(dbc, table, rterid):
> @@ -45,20 +45,20 @@ def do_delete(dbc, table, rterid):
>  
>  
>  if __name__ == '__main__':
> -    parser = OptionParser(version="%prog v0.1")
> +    parser = ArgumentParser(version="%prog v0.1")
>  
> -    parser.add_option("-H", "--host", action="store", dest="dbhost", default="localhost",
> +    parser.add_argument("-H", "--host", action="store", dest="dbhost", default="localhost",
>                        help="Database server to connect to (default: %default)",
>                        metavar="HOST")
> -    parser.add_option("-p", "--port", action="store", dest="dbport", default="5432",
> +    parser.add_argument("-p", "--port", action="store", dest="dbport", default="5432",
>                        help="Database server port to use (default: %default)", metavar="PORT")
> -    parser.add_option("-U", "--user", action="store", dest="dbuser", default="rtevaladmin",
> +    parser.add_argument("-U", "--user", action="store", dest="dbuser", default="rtevaladmin",
>                        help="Database user to connect as (default: %default)", metavar="USERNAME")
> -    parser.add_option("-d", "--database", action="store", dest="dbname", default="rteval",
> +    parser.add_argument("-d", "--database", action="store", dest="dbname", default="rteval",
>                        help="Database to use (default: %default)", metavar="DATABASE")
> -    parser.add_option("-r", "--rterid", action="store", dest="rterid", default=None,
> +    parser.add_argument("-r", "--rterid", action="store", dest="rterid", default=None,
>                        help="rteval run id to remove from the database", metavar="INTEGER")
> -    (opts, args) = parser.parse_args()
> +    opts = parser.parse_args()
>  
>      if opts.rterid is None:
>          print "%s:  Missing --rterid value" % sys.argv[0]
> diff --git a/server/rteval_testserver.py b/server/rteval_testserver.py
> index 6cac85bcfe52..c7f9ce954b21 100644
> --- a/server/rteval_testserver.py
> +++ b/server/rteval_testserver.py
> @@ -30,7 +30,6 @@ import sys
>  import signal
>  from xmlrpc.server import SimpleXMLRPCServer
>  from xmlrpc.server import SimpleXMLRPCRequestHandler
> -from optparse import OptionParser
>  import argparse
>  
>  import xmlrpc_API1
> diff --git a/server/testclient_sendreportfile b/server/testclient_sendreportfile
> index 08317b263f76..dc69a199122c 100755
> --- a/server/testclient_sendreportfile
> +++ b/server/testclient_sendreportfile
> @@ -28,22 +28,22 @@
>  
>  import sys
>  import libxml2
> -from optparse import OptionParser
> +from argparse import ArgumentParser
>  
>  sys.path.append('../rteval')
>  import rtevalclient
>  
>  if __name__ == '__main__':
> -    parser = OptionParser(version="%prog v0.1")
> +    parser = ArgumentParser(version="%prog v0.1")
>  
> -    parser.add_option("-r", "--report", action="store", dest="report", default="summary.xml",
> +    parser.add_argument("-r", "--report", action="store", dest="report", default="summary.xml",
>                        help="Which XML report to send to the XML-RPC server  (default: %default)",
>                        metavar="FILE")
> -    parser.add_option("-X", "--xmlrpc-submit", dest="xmlrpchost", default="localhost:65432",
> +    parser.add_argument("-X", "--xmlrpc-submit", dest="xmlrpchost", default="localhost:65432",
>                        help="Hostname to the XML-RPC server to send the data (default: %default)",
>                        metavar="HOST[:PORT]")
>  
> -    (opts, args) = parser.parse_args()
> +    opts = parser.parse_args()
>  
>      d = libxml2.parseFile(opts.report)
>  
> -- 
> 2.39.3
> 
> 
    - Fixed spelling in commit comments
    Signed-off-by: John Kacur <jkacur@redhat.com>

