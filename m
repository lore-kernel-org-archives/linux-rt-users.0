Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661033AD9C
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745450; cv=none; b=qc+pILdWZSmCtEIG2lyvUe40WXkil5ok4+4NlEEWm3IrcFVWZy30wTQDR6hEm0FyfTw4IctpS12fiwU7PMqiV21j1dhWCnSEOBIRkWiGa1XDAmoSE1CWATR/6ti9zd+9KZ6/XcFacbLNPf/OXB1vEm9rvEbcyZUGHxEBEFc6KiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745450; c=relaxed/simple;
	bh=2uyWVzZGuLDxIYPCHYBUJxsAO+90Ug1aAJlbz6vUaFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rRUdZufaqgPF3gTzl32nVSrSQYro58CD9xHR7AAY5KUWurMoZcXKRhnAtOw5zUPzaX79bUu2Fx2mRSuN3ohDJaSdGgHLpQCpZ4aG0VeT29FKFHfdQbRV0yHXR6hk7gcTy9YF/ka5uR7PgWGmR0981tmPrPy5/AqQKob0Rjtx8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/NvKKN2; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/NvKKN2"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efb708b1a0so10956336d6.3
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745447; x=1787350247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ErxegcYOPd+7+xkFFE/kq7mJfIccXH2ahvmKBMgW0ME=;
        b=Z/NvKKN2i4I0IQ8u/7M/wdjtdKpxerMZFPwaIf3mDloq5xmbhegOuFi6LnbiLiazb1
         s5ZMfNzsORWmwOjsjfGzj0W/Aa958MNDMCoI/+l1SmGcORuP/ylP4Lcv7NEqnA5VS0XP
         Bg+Oj0wUG2Jx2ck/+ckquPJKHriYBbkUc0f3Z2n0GEAkqTOQqAqFCpeqjWVbS0QjxlSy
         DyEsy8DCjYodNBlmM2Ck+kKx0EAlkW5gjoPIOnXbI/4mV9c9Kqou7oeoGhi1UOLhS6Qo
         gBw7VLfLF8gUkZcVY5IZOkebGe0ADa345gD94HHmdZqn56TAkkVHcrwj+uwNtGSIytu+
         nFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745447; x=1787350247;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ErxegcYOPd+7+xkFFE/kq7mJfIccXH2ahvmKBMgW0ME=;
        b=gqpS93SkYH+GLgGA3jqIgoRkGr8ly5ggH0fPFTL8FgDtuHuWuVjGkuWo9bsKDhBkZY
         AnSWc/tly4XQ3wYqHd12yhnUIBzba3/oiMmKtmQvLGVFz34zjzaXSjB3Nmthi0NMA6Eo
         Mg+BKWtYnZCUEHd/Di5BpBiL4cltRMpo6ELbD37tWtVyd4TR3LqJ9FDalQbtQGK99tHh
         XefBexkKElcZLrwj1GgBVlX45CQ2RA/Aeh/3DM08F2GTuGOtBDtCCOXh8TV7y1KKlLgm
         lvN0Gn/19Ef3lGbyD1HnILxfJV7FYWVUiaopNQFDTMY4nUPQWzWLqhF69sxYlnWxe8aQ
         PDEw==
X-Gm-Message-State: AOJu0YwyY23LKPbNz95fdbAMVu+PO84oeMbq+49YY5gehYtSwcsbzROG
	Qca82GRap9XkEZzNRoWtXaEivx8dRCrti9WyQGjvUZDKGTOEOJmeXEUIYyK2Wg==
X-Gm-Gg: AR+sD11AzSJERulL0yvdfJ22vwTmWU5XHmbA+cyFsTQZMdBvyTfD/lA1MLnUrmGtUhs
	Sjnc4iUdB8OXVn5bKhSaG6XurRHD5Wb3eJfCs0SddjDOne5NuMyIqMIpdXpkFMSGN0aI3OgoA0k
	bucB5yffe2HyIL6B6OIlzWaUy80z1LfZJ6w3oyFed/UherGtKqFCL08vq0HLYvoDaanx4az6wLE
	egsXaK5WyVK/2RpfMDqWg7TB8XPnsEhDk+5LhbuxuXuAOZswN3oizS9RpwqHcioA599dg2UfQ6X
	5GE46Ohh+SxplLFZxO9Vz3hhi48Fa3V+88QfCUn3PNiz6XEIVdkj8/nuUe+mW3vSeSVM4wDePEA
	zjl1lmLZZWv/dOXdAAKHF4XPuQHV65JExdOrNi06m4DXfaLhS3706L6VT7BVKCUe024gBBiJm/H
	bn+eXdwydnEx3PWR6ra41ucB/TrIAZcFcmh6CVXZW4HdTAg6eSCBhEEcNPtS38Ytos+11iwLTAB
	jftJ/2sBCIz2KY8aNivmxoq3Ku8+23j3xvXK9sZGvbDUS2Y5Fs/Dd0=
X-Received: by 2002:a05:6214:501e:b0:907:840e:bf11 with SMTP id 6a1803df08f44-90a91cad1damr87899026d6.10.1786745447468;
        Fri, 14 Aug 2026 15:10:47 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:10:46 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 00/23] rteval: Add MCP server for result analysis
Date: Fri, 14 Aug 2026 18:09:59 -0400
Message-ID: <20260814221027.213574-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds an MCP (Model Context Protocol) server for querying
and analyzing rteval test results. The server enables AI assistants and other
MCP clients to programmatically access rteval data for multi-run analysis,
regression detection, and performance trend analysis.

The MCP server provides tools to:
- List and parse rteval XML result files
- Compare multiple test runs side-by-side
- Filter results by kernel version, date range, and latency thresholds
- Extract histogram data and calculate latency percentiles
- Analyze per-CPU latency statistics to identify problematic cores
- Access log files with grep/head/tail filtering
- Compare results against baselines and detect regressions

Target users:
- System administrators running rteval for real-time kernel validation
- QE engineers performing performance regression testing
- CI/CD pipelines requiring automated rteval result analysis
- Developers analyzing system behavior under load

Key features:
- Standards-based MCP protocol implementation
- Comprehensive test suite with integration tests
- Support for both cyclictest and timerlat histogram formats
- Handles overflow buckets and varying histogram sizes
- GPL-2.0-or-later licensed

Dependencies:
- python3-mcp (Fedora package available)
- python3-lxml (standard XML parsing)

Testing:
All tests pass via 'make test' in rteval_mcp/ directory. The server has
been tested with Claude Code as an MCP client.

Installation:
The server can be run from git checkout (./rteval_mcp/rteval-mcp-server)
or installed system-wide. An example MCP configuration file is provided
in mcp.json.example for packagers.

John Kacur (23):
  rteval: Add prototype MCP server for result analysis
  rteval: Implement compare_results functionality in MCP server
  rteval: Add log file access tools to MCP server
  rteval: mcp-server: Add Claude Code plugin configuration
  rteval: Add .mcp.json for project-level MCP server configuration
  rteval: mcp-server: Add rtla command line parser
  rteval: mcp-server: Add batch analysis tool
  rteval: mcp-server: Add query and filter capabilities
  rteval MCP: Add histogram extraction and percentile analysis
  rteval MCP: Reorganize tests into tests/ subdirectory
  rteval MCP: Fix test_new_tools.py to find rteval result files
  rteval MCP: Fix glob patterns to find rteval result files
  rteval MCP: Add integration tests and remove hardcoded examples
  rteval MCP: Add per-CPU latency statistics breakdown
  mcp-server: Add overflow bucket support and cyclictest compatibility
  mcp-server: Make tests generic and add Makefile integration
  mcp-server: Add load information extraction and filtering
  mcp-server: Rename server from rteval to rteval-mcp
  mcp-server: Add GPL-2.0-or-later license headers to all files
  mcp-server: Add Makefile for running tests
  mcp-server: Add demo guide with example queries
  mcp-server: Restructure as Python package with dynamic paths
  mcp-server: Use relative path in .mcp.json and add example for
    installation

 .mcp.json                                |    7 +
 Makefile                                 |   10 +-
 mcp.json.example                         |   11 +
 rteval_mcp/.claude-plugin/plugin.json    |   18 +
 rteval_mcp/DEMO.md                       |  462 +++++
 rteval_mcp/DEPENDENCIES.md               |   33 +
 rteval_mcp/Makefile                      |   51 +
 rteval_mcp/README.md                     |  490 ++++++
 rteval_mcp/__init__.py                   |   13 +
 rteval_mcp/__main__.py                   |   33 +
 rteval_mcp/manifest.json                 |   18 +
 rteval_mcp/rteval-mcp-server             |   21 +
 rteval_mcp/rteval_server.py              | 2019 ++++++++++++++++++++++
 rteval_mcp/tests/test_histogram.py       |   82 +
 rteval_mcp/tests/test_mcp_integration.py |  220 +++
 rteval_mcp/tests/test_new_tools.py       |  142 ++
 rteval_mcp/tests/test_per_cpu_stats.py   |  134 ++
 17 files changed, 3763 insertions(+), 1 deletion(-)
 create mode 100644 .mcp.json
 create mode 100644 mcp.json.example
 create mode 100644 rteval_mcp/.claude-plugin/plugin.json
 create mode 100644 rteval_mcp/DEMO.md
 create mode 100644 rteval_mcp/DEPENDENCIES.md
 create mode 100644 rteval_mcp/Makefile
 create mode 100644 rteval_mcp/README.md
 create mode 100644 rteval_mcp/__init__.py
 create mode 100644 rteval_mcp/__main__.py
 create mode 100644 rteval_mcp/manifest.json
 create mode 100755 rteval_mcp/rteval-mcp-server
 create mode 100755 rteval_mcp/rteval_server.py
 create mode 100644 rteval_mcp/tests/test_histogram.py
 create mode 100644 rteval_mcp/tests/test_mcp_integration.py
 create mode 100644 rteval_mcp/tests/test_new_tools.py
 create mode 100644 rteval_mcp/tests/test_per_cpu_stats.py

-- 
2.55.0

